# Prerequisites & Tools

To get the most out of these dotfiles, you should install the following tools. 

> [!TIP]
> **Automatic Installation**: These are now automatically handled by `chezmoi apply` via `run_onchange_` scripts. If you add a tool to the list, `chezmoi` will install it for you next time you apply.

## 🚀 Core Requirements

| Tool | Purpose | Installation |
|---|---|---|
| **[chezmoi](https://www.chezmoi.io/)** | Dotfile Manager | `winget install chezmoi` / `brew install chezmoi` |
| **Git** | Version Control | `winget install Git.Git` / `brew install git` |
| **[Warp](https://www.warp.dev/)** | Modern AI-powered terminal | `winget install Warp.Warp` / `brew install --cask warp` |

## ✨ Shell Enhancements (Highly Recommended)

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

## 🛠️ Development Tools

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

Run this from an Administrator PowerShell to install the bulk of these at once:
```powershell
.\windows\packages.ps1
```
