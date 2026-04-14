# Changelog

All notable changes to this dotfiles repo will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Removed PowerShell and Bash as primary shells; standardized on Zsh across macOS and WSL
- Replaced Warp with Ghostty (macOS) and Windows Terminal (WSL/Windows)
- Removed `dot_bash_profile`, `dot_bashrc.tmpl`, and PowerShell profile
- Removed `fzf.bash` and `fzf.ps1`; fzf integration is now Zsh-only via `fzf.zsh`
- Removed `dot_warp/` themes directory; Ghostty themes remain in `dot_config/ghostty/themes/`
- `linux/packages.sh` now installs Zsh and sets it as the default login shell
- `windows/install.ps1` now installs Zsh inside WSL and sets it as the default login shell

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
