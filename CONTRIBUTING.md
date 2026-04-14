# Contributing

Thanks for taking the time to contribute! Since this is a personal dotfiles repo, contributions are primarily for your own reference.

## Branching

| Branch | Purpose |
|---|---|
| `main` | Stable, always-deployable dotfiles |
| `feat/<name>` | Adding a new tool config or feature |
| `fix/<name>` | Fixing a broken config |
| `chore/<name>` | Non-functional updates (docs, cleanup) |

## Commit Messages

This repo follows [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short description>

[optional body]
```

**Types:** `feat`, `fix`, `chore`, `docs`, `refactor`, `test`

**Scope examples:** `zsh`, `git`, `tmux`, `ghostty`, `ssh`, `starship`

**Examples:**

```
feat(zsh): add fzf history search binding
fix(git): correct delta pager configuration
chore(brew): add ripgrep to Brewfile
docs(readme): update bootstrap instructions
```

## Adding a New Dotfile

1. Place the file in the chezmoi source directory using its naming convention:
   - Prefix dotfiles with `dot_` (e.g. `dot_zshrc` → `~/.zshrc`)
   - Append `.tmpl` if the file needs OS/machine-specific templating
2. Use `chezmoi add <file>` to let chezmoi track it
3. Use `chezmoi edit <file>` to modify managed files
4. Run `chezmoi diff` to preview what will change
5. Run `chezmoi apply` to apply changes

## Testing Changes

Before committing, verify your changes on each applicable OS:

- **Zsh:** `zsh -n ~/.zshrc`
- **Git:** `git config --list --global`
- **chezmoi:** `chezmoi diff` (should show no unexpected changes after apply)

## Updating the Changelog

Add entries to `CHANGELOG.md` under `[Unreleased]` following the [Keep a Changelog](https://keepachangelog.com) format. Tag releases with semantic versions when you reach a stable milestone.
