# Prerequisites & Tools

To get the most out of these dotfiles, you should install the following tools. 

> [!TIP]
> **WSL-First Workflow**: We prioritize **WSL (Windows Subsystem for Linux)** for all development tasks on Windows. Most tools listed below are installed inside the WSL environment, keeping the Windows host clean.

## 🚀 Core Requirements

| Tool | Purpose | Installation |
|---|---|---|
| **[chezmoi](https://www.chezmoi.io/)** | Dotfile Manager | `winget install chezmoi` / `brew install chezmoi` |
| **Git** | Version Control | `winget install Git.Git` / `brew install git` |
| **[Ghostty](https://ghostty.org/)** | Modern terminal for macOS | `brew install --cask ghostty` |
| **Windows Terminal** | Terminal for WSL on Windows | Ships with Windows 11; `winget install Microsoft.WindowsTerminal` |

## ✨ Shell Enhancements (WSL & macOS)

These tools power the aliases and the visual experience:

| Tool | Purpose | Command for Alias |
|---|---|---|
| **[Starship](https://starship.rs/)** | Modern, fast, cross-shell prompt | (Applied to all shells) |
| **[fzf](https://github.com/junegunn/fzf)** | Fuzzy finder for command history and files | `ctrl+r`, `ctrl+t` |
| **[ripgrep](https://github.com/BurntSushi/ripgrep)** | Ultra-fast search tool (replacement for grep) | `rg` |
| **[delta](https://github.com/dandavison/delta)** | Syntax-highlighting pager for git log/diff | `gl`, `gd` |
| **[bat](https://github.com/sharkdp/bat)** | Cat replacement with syntax highlighting | (Used by fzf previews) |
| **[eza](https://github.com/eza-community/eza)** | Modern replacement for `ls` | `ls`, `ll`, `la` |
| **[fd](https://github.com/sharkdp/fd)** | Fast replacement for `find` | (Used by fzf) |

## 🛠️ Development Tools (WSL & macOS)

| Tool | Purpose | Aliases Enabled |
|---|---|---|
| **Node.js** | JavaScript Runtime | `npm`, `npx` |
| **pnpm** | Fast, disk-efficient package manager | `pi`, `pa`, `pr`, `pd`, etc. |
| **Python** | Needed for the local file server | `serve` |
| **curl** | (Built-in on Windows 10/11 & macOS) | `ip`, `weather` |
| **jq / yq** | Command-line JSON/YAML processors | Reference only |

## 📦 Package Managers by OS

We recommend using these to manage the tools above:

- **Windows**: [Winget](https://github.com/microsoft/winget-cli) (Built-in) or [Scoop](https://scoop.sh/)
- **macOS**: [Homebrew](https://brew.sh/)
- **Linux**: Homebrew or native `apt`/`pacman`/`dnf`

---

## ⚡ Quick Install (Windows)

Run this from an Administrator PowerShell to bootstrap the environment (installs tools and sets up Zsh in WSL):
```powershell
.\windows\install.ps1
```
