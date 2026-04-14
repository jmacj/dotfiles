# Dotfiles Repo — Full Explanation

This is a **personal dotfiles repository** — a collection of configuration files for your shell, tools, and OS — managed with **[chezmoi](https://www.chezmoi.io/)**, a dotfile manager that handles cross-platform templating and syncing via Git.

---

## 🗂️ Overall Structure

```
dotfiles/
├── .chezmoi.toml.tmpl        ← chezmoi's own config (identity, git, diff)
├── dot_*                     ← your shell/tool config files
├── dot_config/               ← ~/.config/* tool configs
├── dot_ssh/                  ← SSH client config
├── linux/                    ← Linux/WSL-specific: packages
├── windows/                  ← Windows-specific: minimal bootstrap for WSL
├── run_onchange_after_linux_install-packages.sh.tmpl
├── run_onchange_after_macos_install-packages.sh.tmpl
├── run_onchange_after_windows_install-packages.ps1.tmpl
├── .chezmoiignore            ← files to exclude from $HOME
├── PREREQUISITES.md          ← full tool/package requirements
└── Makefile                  ← convenience wrappers for chezmoi commands
```

> **chezmoi naming convention**: `dot_bashrc` → installs as `~/.bashrc`. Files ending in `.tmpl` are Go templates — chezmoi fills in variables (OS, name, email) before writing to disk.

---

## 🔧 chezmoi Config — `.chezmoi.toml.tmpl`

```toml
[data]
    name    = "{{ promptStringOnce ... }}"
    email   = "{{ promptStringOnce ... }}"
    context = "{{ promptStringOnce ... }}"   # "personal" or "work"

[git]
    autoCommit = true   # auto git-commit any source changes
    autoPush   = true   # auto push to GitHub

[diff]
    pager = "delta"     # use delta for pretty diff output

[edit]
    apply = true        # auto-apply changes when using 'chezmoi edit'
```

On first run, chezmoi **interactively asks** for your name, email, and context (personal/work), then stores them. These become template variables (`.name`, `.email`, `.chezmoi.os`) used across all `.tmpl` files.

---

## 🐚 Shell Config Files

Environment variables sourced by Zsh:

| Variable | Value |
|---|---|
| `EDITOR` / `VISUAL` | `vim` |
| `LANG` / `LC_ALL` | `en_US.UTF-8` |
| `TERM` | `xterm-256color` |
| `HISTSIZE` / `HISTFILESIZE` | 10,000 / 20,000 |
| `PAGER` | `less` (with smart flags) |
| `FZF_DEFAULT_COMMAND` | ripgrep, shows hidden files, excludes `.git` |
| `FZF_DEFAULT_OPTS` | Theme: Catppuccin Mocha |
| `RIPGREP_CONFIG_PATH` | points to `~/.config/ripgrep/ripgreprc` |
| `PATH` | prepends Homebrew (macOS/Linux) + `~/.local/bin` |
| `NVM_DIR` | `~/.nvm` |

### `dot_aliases.tmpl` → `~/.aliases`

Shell shortcuts sourced by Zsh:

| Category | Examples |
|---|---|
| **Navigation** | `..`, `...`, `....`, `~` |
| **File listing** | `ls`, `ll`, `la` — uses **eza** if available, falls back to `ls` |
| **Git** | `gs`, `ga`, `gc`, `gcm`, `gca`, `gco`, `gcb`, `gm`, `gmnf`, `gp`, `gpl`, `gl`, `gd`, `gundo` |
| **Utilities** | `grep` (colored), `mkdir -pv`, `df -h`, `du -h`, `sudo` (expanded) |
| **Networking** | `ip` (public IP), `localip`, `ports`, `pubkey` (multi-platform clipboard) |
| **Dev** | `ni`, `pa`, `pi`, `pr`, `pd`, `nci`, `pci`, `serve` |
| **Terminal** | **Ghostty** (macOS), **Windows Terminal** (WSL/Windows) |
| **Open** | `open` (`xdg-open` on Linux, `wslview` on WSL) |

Sources `~/.local_aliases` at the end for machine-local aliases that aren't committed.

### `dot_functions` → `~/.functions`

Utility shell functions sourced by Zsh:

| Function | What it does |
|---|---|
| `mkcd <dir>` | `mkdir -p` + `cd` in one step |
| `extract <file>` | Extracts any archive (`.tar.gz`, `.zip`, `.7z`, `.rar`, etc.) |
| `port <number>` | Kills whatever process is listening on that port |
| `weather [city]` | Fetches weather from `wttr.in` |
| `backup <file>` | Copies `file` → `file.bak.YYYYMMDD_HHMMSS` |
| `up [N]` | Go up N directories (`up 3` = `cd ../../..`) |
| `gi <lang>` | Generate a `.gitignore` from gitignore.io |
| `httpheaders <url>` | Prints sorted HTTP response headers |
| `reload_shell` | Restarts your shell (`exec $SHELL -l`) |
| `path_add <dir>` | Safely adds a directory to PATH if it exists and isn't there |
| `path_remove <dir>` | Removes a directory from PATH |
| `is_wsl` | Detects if the environment is WSL |

### `dot_zshrc.tmpl` → `~/.zshrc`

Primary shell config (skips if non-interactive). Sources `.exports`, `.aliases`, `.functions`, then:
- `setopt` flags: `AUTO_CD`, `CORRECT`, `SHARE_HISTORY`, `EXTENDED_HISTORY`, `INC_APPEND_HISTORY`, `HIST_IGNORE_DUPS`
- **Visual Polish**: High-visibility colored completion headers and case-insensitive menu select.
- Emacs keybindings + up/down arrow history search
- **WSL Optimizations**: Sets `BROWSER=wslview` if available.
- Sources nvm, fzf, Starship prompt.

### `dot_zprofile.tmpl`

Login shell entry point — sources `.zshrc`.

---

## ⚙️ Git Config — `dot_gitconfig.tmpl` → `~/.gitconfig`

```toml
[user]
    name  = {{ .name }}    # injected from chezmoi template data
    email = {{ .email }}
```

Key settings:

| Section | Setting | Why |
|---|---|---|
| `core` | `autocrlf = input` | Stores LF in repo, converts CRLF on Windows checkout |
| `core` | `pager = delta` | Syntax-highlighted diffs |
| `pull` | `rebase = true` | Always rebase on pull |
| `push` | `default = current` | Push to same-named remote branch |
| `merge` | `ff = false` | Always create a merge commit |
| `merge` | `conflictstyle = zdiff3` | Better conflict markers (Git 2.35+) |
| `rebase` | `autosquash + autostash` | Convenience for interactive rebases |
| `rerere` | `enabled = true` | Remembers how you resolved conflicts |
| `help` | `autocorrect = 1` | Auto-run corrected commands |
| `commit` | `verbose = true` | Show diff in commit editor |
| `delta` | `side-by-side = true` | Side-by-side diff view |

**Git aliases**: `lg`, `lga` (graph log), `undo`, `unstage`, `cleanup` (delete merged branches), `whoami`

**URL shortcuts**: `gh:repo` → `git@github.com:repo`, `gl:repo` → GitLab

**Includes** `~/.gitconfig.local` for machine-specific overrides (not committed).

---

## 🗃️ `dot_config/` — Tool Configs

| File | Purpose |
|---|---|
| `starship.toml` | Cross-shell prompt (Zsh) |
| `fzf/fzf.zsh` | fzf key bindings and completion for Zsh |
| `ripgrep/ripgreprc` | Default ripgrep flags (includes `web` type) |
| `ghostty/config` | Ghostty terminal configuration (macOS) |
| `tmux/tmux.conf` | tmux terminal multiplexer (optimized for Vim, no Escape lag) |
| `dot_ssh/config.tmpl` | SSH client config (templated for work vs personal keys) |

---

## 🍎 macOS — `macos/`

### `Brewfile`

Declares all Homebrew packages — installed via `brew bundle`. Defines taps, CLI tools, and casks in one file.

### `defaults.sh`

Applies macOS system preference tweaks via the `defaults` command:

- **General**: Dark mode, save to disk (not iCloud), disable smart quotes/periods
- **Keyboard**: Fast key repeat, disable autocorrect, full keyboard access
- **Finder**: Show hidden files, extensions, path bar, list view, folders on top
- **Dock**: Auto-hide with zero delay, 48px icons, no recent apps
- **Screenshots**: Save PNG to `~/Desktop/Screenshots`, no shadow
- **TextEdit**: Plain text mode by default
- Restarts Finder, Dock, SystemUIServer, Safari after applying

---

## 🪟 Windows — `windows/`

### `install.ps1`

Bootstrap script (run as Admin in PowerShell 7+):
1. Installs **chezmoi** via `winget` (or direct download fallback)
2. Runs `chezmoi init --apply <repo>` to clone and apply all dotfiles
3. Runs `packages.ps1` to install dev tools
4. Configures **Zsh** inside **WSL** as the primary development environment.

| Tool | Purpose |
|---|---|
| Git | Required for chezmoi |
| Windows Terminal | Required to run WSL |
| Nerd Font | Terminal rendering |
| chezmoi | Dotfile manager |
| age | Encryption for chezmoi |

---

## 🛠️ Makefile — Convenience Shortcuts

| Command | Equivalent |
|---|---|
| `make install` | `chezmoi apply` |
| `make update` | `chezmoi update` (pull + apply) |
| `make diff` | `chezmoi diff` (preview changes) |
| `make status` | `chezmoi status` |
| `make edit FILE=~/.zshrc` | `chezmoi edit ~/.zshrc` |
| `make clean` | `chezmoi purge` ⚠️ destructive |
| `make doctor` | `chezmoi doctor` (diagnostics) |

---

## 🔒 Machine-Local Overrides (Not Committed)

These files are **gitignored** but auto-sourced — for secrets, work-specific settings, etc.:

| File | Sourced by |
|---|---|
| `~/.gitconfig.local` | `.gitconfig` via `[include]` |
| `~/.local_aliases` | `.zshrc` |
| `~/.local_exports` | `.zshrc` |
| `~/.local_zshrc` | `.zshrc` |

---

## 🔁 How It All Flows

```
chezmoi init --apply <repo>
    ↓
reads .chezmoi.toml.tmpl → prompts for name/email/context
    ↓
processes all .tmpl files (fills in OS, name, email, context variables)
    ↓
writes final files to ~ (e.g. ~/.zshrc, ~/.gitconfig, ~/.aliases, ...)
    ↓
shell starts → sources .exports → .aliases → .functions → tool inits
```
