# dotfiles

Personal configuration files managed with [chezmoi](https://www.chezmoi.io/), covering **Windows**, **macOS**, and **Linux**.

Full list of tools used: **[PREREQUISITES.md](PREREQUISITES.md)**

## Quick Start

### macOS / Linux

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/jmacj/dotfiles.git
```

Or using the bootstrap script:

```sh
./install.sh
```

### Windows (WSL + Zsh)
Environment is bootstrapped via PowerShell, then transitions to WSL/Ubuntu with Zsh.

```powershell
(irm https://get.chezmoi.io/ps1) | powershell -c -
chezmoi init --apply https://github.com/jmacj/dotfiles.git
```

Or using the bootstrap script:

```powershell
.\windows\install.ps1
```

## Repo Locations

| OS | Dotfiles path |
|---|---|
| Windows | `C:\Users\<username>\dotfiles` |
| macOS / Linux | `~/dotfiles` |

chezmoi stores its source state at `~/.local/share/chezmoi`.

## Structure

```
dotfiles/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── PULL_REQUEST_TEMPLATE.md
├── .chezmoiignore              # Meta-files to exclude from $HOME
├── .chezmoi.toml.tmpl        # chezmoi's own config (identity/workflow)
├── dot_config/
│   ├── fzf/
│   │   └── fzf.zsh
│   ├── ghostty/                  # Modern terminal (macOS)
│   ├── ripgrep/
│   │   └── ripgreprc
│   ├── starship.toml              # Cross-shell prompt
│   └── tmux/
│       └── tmux.conf
├── dot_ssh/
│   └── config.tmpl               # SSH client config
├── macos/
│   ├── Brewfile                   # Homebrew bundle
│   └── defaults.sh               # macOS system preferences
├── windows/
│   ├── install.ps1               # Bootstrap script
│   └── packages.ps1              # Winget packages
├── .editorconfig
├── dot_aliases.tmpl
├── dot_curlrc
├── dot_exports.tmpl
├── dot_functions
├── dot_gitconfig.tmpl
├── dot_gitignore_global
├── dot_wgetrc
├── dot_zprofile.tmpl
├── dot_zshrc.tmpl
├── run_onchange_after_macos_install-packages.sh.tmpl
├── run_onchange_after_windows_install-packages.ps1.tmpl
├── Makefile
├── PREREQUISITES.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## How It Works

chezmoi uses a **source directory** with specific naming conventions:

| Source name | What it becomes |
|---|---|
| `dot_zshrc.tmpl` | `~/.zshrc` |
| `dot_gitconfig.tmpl` | `~/.gitconfig` |
| `dot_config/starship.toml` | `~/.config/starship.toml` |

Files ending in `.tmpl` are Go templates — chezmoi injects variables like OS, username, and email before writing to disk.

## Day-to-Day Usage

```sh
# Apply dotfiles to current machine
chezmoi apply

# Preview what would change
chezmoi diff

# Edit a managed file
chezmoi edit ~/.zshrc

# Add a new file to be managed
chezmoi add ~/.config/somefile

# Pull latest from GitHub and apply
chezmoi update

# Or use the Makefile shortcuts
make update
make diff
```

## Machine-Local Overrides

Files committed here are shared across all machines. For local-only config, create these files (they're gitignored and auto-sourced):

| File | Sourced by |
|---|---|
| `~/.gitconfig.local` | `.gitconfig` via `[include]` |
| `~/.local_aliases` | `.zshrc` |
| `~/.local_exports` | `.zshrc` |

## Security & Standards

This repository is hardened following modern security best practices:
- **Permission Lockdown**: Bootstrap script automatically secures `~/.ssh` and `~/.gnupg` (700).
- **SSH Hardening**: Disabled `ForwardAgent` and enabled `HashKnownHosts` by default.
- **Git Integrity**: Enabled `fsckobjects` for all transfers to prevent corruption.
- **Credential Protection**: Global gitignore excludes `.netrc`, `.npmrc`, and common secret patterns.
- **Resilient Shell**: Environment-aware PATH management and OS-specific guards.
- **Expert Productivity**: High-performance settings for Tmux, Git (Delta, verbose commits), and Zsh.
- **Modern Stack**: Optimized for **Ghostty** (macOS) and **Windows Terminal** (WSL) with modern CLI tools (`eza`, `bat`, `fzf`).

## 🔐 Private Repositories

If this repository is private, you can initialize it using one of the following methods:

### SSH (Recommended)
1. **macOS / Linux (Bash)**:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:jmacj/dotfiles.git
   ```

2. **Windows (PowerShell)**:
   ```powershell
   & (iwr https://get.chezmoi.io/ps1) -Repo 'git@github.com:jmacj/dotfiles.git'
   ```

> [!IMPORTANT]
> Change `jmacj/dotfiles.git` to your actual GitHub path. This requires that you have your **SSH keys** already added to your GitHub account.

### HTTPS
You will be prompted for your GitHub **username** and a **Personal Access Token (PAT)**:
```powershell
& "$HOME\bin\chezmoi.exe" init --apply https://github.com/jmacj/dotfiles.git
```

---

## License

[MIT](LICENSE)
