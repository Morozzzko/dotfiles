#!/usr/bin/env python3

import json
import re
import shlex
import sys


def shell_operators(command):
    operators = []
    quote = None
    escaped = False
    index = 0

    while index < len(command):
        character = command[index]

        if escaped:
            escaped = False
        elif character == "\\" and quote != "'":
            escaped = True
        elif quote:
            if character == quote:
                quote = None
        elif character in ("'", '"', "`"):
            quote = character
        elif command.startswith("&&", index) or command.startswith("||", index):
            operators.append((index, command[index : index + 2]))
            index += 1
        elif character == ";":
            operators.append((index, character))

        index += 1

    return operators


def segments(command, operators):
    result = []
    start = 0

    for index, operator in operators:
        result.append(command[start:index].strip())
        start = index + len(operator)

    result.append(command[start:].strip())
    return result


def starts_with(command, name):
    return re.match(rf"^(?:[A-Za-z_][A-Za-z0-9_]*=\S+\s+)*{name}(?:\s|$)", command) is not None


def fixed_loop(command):
    match = re.search(r"\bfor\s+[A-Za-z_][A-Za-z0-9_]*\s+in\s+(.+?)\s*;\s*do\b", command, re.S)
    if not match:
        return False

    values = match.group(1)
    if re.search(r"[$*?`\n]|\.\.", values):
        return False

    try:
        return 1 < len(shlex.split(values)) <= 8
    except ValueError:
        return False


def is_dependency(left, operator, right):
    if starts_with(left, "mktemp") and starts_with(right, "trap"):
        return True

    if operator == "&&" and (
        starts_with(left, "command")
        or left.startswith("[ ")
        or left.startswith("[[ ")
        or starts_with(left, "test")
    ):
        return True

    if operator == "||" and re.match(r"^(true|false|exit|return)\b", right):
        return True

    prerequisite = re.search(r"\b(install|bootstrap|setup|build|compile|generate)\b", left)
    verify = re.search(r"\b(test|check|lint|verify|build)\b", right)
    if operator == "&&" and prerequisite and verify:
        return True

    return False


def violation(command):
    operators = shell_operators(command)
    if not operators:
        return None

    parts = segments(command, operators)
    compound_shell = re.match(r"^\s*(?:for|while|until|if|case)\b", command) is not None

    if any(starts_with(part, "cd") for part in parts):
        return "Do not chain cd with another command. Use the hook working directory, an absolute path, or the tool's -C/--cwd option."

    if fixed_loop(command):
        return "Do not loop over a small fixed list in shell. Use separate Bash calls or one command that accepts multiple paths."

    if re.search(r"\b(?:echo|printf)\b[^\n]*(?:-{3,}|={3,})", command):
        return "Do not print section-header separators between commands. Split the operations into separate Bash calls."

    if any(operator == ";" for _, operator in operators) and not compound_shell:
        return "Do not sequence independent operations with ';'. Split them into separate Bash calls."

    for position, (_, operator) in enumerate(operators):
        if operator not in ("&&", "||"):
            continue
        if not is_dependency(parts[position], operator, parts[position + 1]):
            return f"Do not sequence independent operations with '{operator}'. Split them into separate Bash calls unless the second command genuinely depends on the first."

    return None


def main():
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, UnicodeDecodeError):
        return

    tool_input = payload.get("tool_input") or {}
    command = tool_input.get("command")
    if not isinstance(command, str):
        return

    reason = violation(command)
    if reason:
        json.dump(
            {
                "hookSpecificOutput": {
                    "hookEventName": "PreToolUse",
                    "permissionDecision": "deny",
                    "permissionDecisionReason": reason,
                }
            },
            sys.stdout,
        )


if __name__ == "__main__":
    main()
