# Global instructions

These rules apply to every project. Project-level `CLAUDE.md` files may add to them but should not relax them.

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
