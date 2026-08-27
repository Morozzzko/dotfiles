# Global instructions

These rules apply to every project. Project-level `CLAUDE.md` files may add to them but should not relax them.

## Simplicity is a correctness marker

The preferred solution is a simple and a standard one. If you have to run sed to read a file – you're doing something wrong. If you have to pass full paths to run something that should have been available in PATH – you're doing something wrong. If you're passing environment variables to disable certain behaviors that are not directly related to task at hand – you're doing something wrong.

Use that as a marker and a self-reflection tool. Pause and reassess instead of trying to trick the system using complicated commands.

## Working with git

While you MAY work on the main branch, do not commit there directly unless explicitly (in no unclear terms) prompted to work on main specifically by user. Any changes go through branches and PRs, no matter how small.

## superpowers and generated design documents

Plans and other artifacts of planning a task should not be committed to the repo.
Before creating a pull request make sure that docs/superpowers is not committed to the PR.

## Comments

Avoid leaving comments that explain what is being done or how it's being done – that is apparent from the code. Prefer comments that give wider context as to why a certain decision is made – but only in cases where that can't reasonably be inferred from the context of the change (PR) or from the code itself.

Avoid leaving `ponytail:` comments in code.

For most things, avoid leaving comments at all. Sometimes you'd want to leave a comment explaining why exactly a piece of code was done – reference to a spec, an RFC, or something. Don't – that's something we do in a task or in the PR description.

## Bash command discipline

**Hard rules:**

- **One conceptual operation per Bash call.** No chaining with `;`, `&&`, `||`, or `|` unless the chained semantics are genuinely required (e.g. piping data into another command that needs stdin, or rolling back a partial change on failure). "I want to see X then Y" is NOT a valid reason — split into two Bash calls.
- **Never chain `cd` with another command.** Use absolute paths in every command instead. Pass `--cwd`, `-C`, or `--filter` flags where the tool supports them (e.g. `git -C /abs/path status`, `pnpm --filter <pkg> test`). The working directory persists between Bash calls within a session, but relying on `cd` to set it is fragile and chained `cd && ...` defeats permission matching.
- **Skip section-header separators.** Don't emit `printf "---"` / `echo "===== foo ====="` between sub-commands to visually group output. Split into separate Bash calls; the harness already labels each call with its description.
- **Prefer dedicated tools over shelling out.** Use Read (not `cat`/`head`/`tail`), Glob (not `find`), and Grep (not `grep`/`rg`) whenever you're inspecting source files. Reserve Bash for things that genuinely need a shell: running tests, invoking package managers, git/gh operations, awk/jq/sed transformations against multiple files, etc.
- **Don't compose with shell control flow when there's a direct call.** A `for f in ...; do cmd $f; done` loop with three iterations should be three separate Bash calls (or one tool call that accepts multiple paths). Reserve `for`/`while` for cases where the iteration logic genuinely lives in the shell (e.g. processing the output of another command line-by-line in a way that can't be expressed via xargs).

**Why this matters specifically here:**

- The user's allowlist is well-tuned; chained commands silently bypass it and force one-off prompts.
- Each Bash call is shown to the user with its description — chained mega-commands produce one big opaque blob; split calls produce a readable timeline of what you did.
- Per-call descriptions become accurate (each call describes one thing), which is what reviewers skim when auditing a session.

**Exception:** when a chain is the only correct way (e.g. `pnpm install && pnpm test` for a true sequential dependency, or `mktemp && trap cleanup EXIT`), do it — but state in the call's description why the chain is required.
