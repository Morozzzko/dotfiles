# Igor's dotfiles

This is a repo with my local setup. It's a public repo that is available to every curious soul with GitHub.

The idea behind the current iteration is to give me an ability to spin off new environments locally. I realized that I'd rather have separate user spaces for work and personal projects, and that means that I'll have to set up things ... rather regularly

So here's the process:

1. Provision OS – make sure the basic dependencies are installed.
2. Sync brew – remove things that are not listed in Brewfile, install those that were removed. All computers [should] share the same set of important dependencies. Removal is not implemented at the moment, but I'd prefer to have it as a "migration"
3. Configure shell – install fish, configure it, etc.
4. Configure nvim – ...
5. Configure other apps

The `~/.profile` file is shared, while secrets are sourced from `~/.profile_secrets`. 

## Shared AI skills

Personal skills shared by Claude Code and Codex live in `skills/<skill-name>/`. Each skill
uses the portable Agent Skills layout and has a required `SKILL.md`:

```text
skills/
└── example/
    ├── SKILL.md
    ├── scripts/
    └── references/
```

Run `make skills` after adding or removing a skill. The command stows the same package into
both `~/.claude/skills/` and `~/.codex/skills/`, preserving Codex's bundled `.system`
directory and unrelated skills installed by other tools.

Keep shared skill frontmatter to the common `name` and `description` fields. Supporting files
are portable. Avoid tool-specific features such as Claude's dynamic command injection in
shared skills. Codex-only UI metadata can live in `agents/openai.yaml`.

## Codex

The `codex` Stow package manages `~/.codex/config.toml`. Authentication, sessions, caches,
downloaded plugin bundles, and other runtime state under `~/.codex` remain local.

Installed plugins are declared in `codex-plugins.conf`. The machine setup runs
`bin/codex/setup` to install or refresh them through the Codex CLI rather than committing
the plugin cache.

## TL;DR of the config

Shell: fish in iTerm (for real)
Editor: neovim. Not a poweruser tho
AIs: Claude Code, Open Code, Happy
Dev tools: asdf, k9s, lazygit, tig, hub, gh
Infra: postgres.app, docker desktop
Theme: catppuccin
