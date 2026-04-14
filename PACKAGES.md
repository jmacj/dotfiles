# Package Inventory

This file lists all packages and tools managed by these dotfiles, categorized by their role and installation platform.

## 🛠️ Foundational Tools
Required on all host machines to manage the dotfiles themselves.

| Tool | Purpose | Windows (Native) | macOS (Native) |
|---|---|---|---|
| **[chezmoi](https://www.chezmoi.io/)** | Dotfile Manager | `winget` | `brew` |
| **Git** | Version Control | `winget` | `brew` |
| **[age](https://github.com/FiloSottile/age)** | Secret Decryption | `winget` | `brew` |

---

## 🖥️ Terminal & Visual Environment
Host-side configurations for the best visual experience.

| Tool | Purpose | Platform |
|---|---|---|
| **[Ghostty](https://ghostty.org/)** | Primary Terminal | macOS |
| **Windows Terminal** | Primary Terminal | Windows |
| **JetBrains Mono Nerd Font** | Icon & Symbol rendering | Windows / macOS |

---

## 🐚 Core Shell & Utilities (WSL / Linux / macOS)
The heart of the development environment.

| Tool | Purpose | Command |
|---|---|---|
| **Zsh** | Standardized Shell | `zsh` |
| **[Starship](https://starship.rs/)** | Modern Prompt | prompt init |
| **tmux** | Terminal Multiplexer | `tmux` |
| **htop** | Process Monitor | `htop` |
| **tree** | Directory Visualization | `tree` |

---

## ✨ Modern CLI Replacements (WSL / Linux / macOS)
High-performance alternatives to traditional Unix tools.

| Tool | Replacement For | Command |
|---|---|---|
| **fzf** | find / grep | `ctrl+r`, `ctrl+t` |
| **ripgrep** | grep | `rg` |
| **eza** | ls | `ls`, `ll`, `la` |
| **bat** | cat | `bat` |
| **fd** | find | `fd` |
| **delta** | git diff/log | `gl`, `gd` |

---

## ⚙️ Development & Maintenance (WSL / Linux / macOS)
Tools for coding, processing, and system maintenance.

| Category | Tools |
|---|---|
| **Processors** | `curl`, `wget`, `jq`, `yq`, `make` |
| **Node.js** | `nvm` (Node Version Manager), `pnpm` |
| **Git Extras** | `gh` (GitHub CLI), `git-lfs` |
| **Lint/Format** | `shellcheck`, `shfmt`, `hadolint` |

---

## 📦 How to Install
- **Windows**: Run `.\windows\install.ps1` from an Admin PowerShell.
- **macOS**: `chezmoi apply` handles the `Brewfile` automatically.
- **Linux/WSL**: `chezmoi apply` handles the `packages.sh` automatically.
