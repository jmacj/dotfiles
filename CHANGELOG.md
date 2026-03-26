# Changelog

All notable changes to this dotfiles repo will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive cross-platform configuration for Windows (PowerShell 5.1/7+), macOS (Zsh), and Linux (Bash)
- Standardized Windows support with PowerShell profile located at `Documents/WindowsPowerShell/`
- Extensive alias synchronization across all shells for Git, npm, and pnpm
- Advanced Git configuration including syntax-highlighted diffs (Delta), auto-correct, and productivity aliases
- Robust security defaults for SSH (`ForwardAgent` disabled, `HashKnownHosts` enabled) and file permissions
- Modern CLI tool integrations: Starship prompt, fzf, ripgrep, bat, delta, and the **Warp** terminal
- Automated cross-platform package installation via `run_onchange_` scripts (Winget & Homebrew)
- Dedicated **`PREREQUISITES.md`** guide listing all required and recommended tools
- Repository hygiene with `.chezmoiignore` to keep home directories clean of metadata
- Convenience `Makefile` for streamlined chezmoi workflows
- Machine-local override support for secrets and local-only settings
- Comprehensive documentation for setup, day-to-day usage, and private repository handling

[Unreleased]: https://github.com/jmacj/dotfiles/commits/main
