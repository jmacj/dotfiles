# Tmux Keybindings Cheatsheet

This document lists the keybindings for the tmux configuration in this repository.

**Legend:**
- **Default**: Standard tmux keybinding.
- **Custom**: Custom binding defined in `tmux.conf`.

**Key Notation:**
- `C-` : **Control** key (e.g., `C-a` is `Ctrl + a`)
- `M-` : **Meta** or **Alt** key (e.g., `M-x` is `Alt + x`)
- `S-` : **Shift** key (e.g., `S-Left` is `Shift + Left Arrow`)

## Prefix Key

The prefix key has been changed from the default `Ctrl-b`.
- **`Ctrl-a`** (Custom)

---

## General Commands

| Key | Action | Source |
|-----|--------|--------|
| `Prefix + r` | Reload tmux configuration | **Custom** |
| `Prefix + ?` | List all keybindings | Default |
| `Prefix + d` | Detach from session | Default |
| `Prefix + :` | Enter command prompt | Default |

## Sessions

| Key | Action | Source |
|-----|--------|--------|
| `Prefix + s` | List sessions | Default |
| `Prefix + $` | Rename current session | Default |
| `Prefix + (` | Switch to previous session | Default |
| `Prefix + )` | Switch to next session | Default |
| `Prefix + L` | Switch to last session | Default |

## Windows (Tabs)

| Key | Action | Source |
|-----|--------|--------|
| `Prefix + c` | Create new window (in current path) | **Custom** |
| `Prefix + ,` | Rename current window | Default |
| `Prefix + n` | Next window | Default |
| `Prefix + p` | Previous window | Default |
| `Prefix + w` | List windows | Default |
| `Prefix + 0-9` | Select window by number | Default |
| `Prefix + &` | Kill current window | Default |

## Panes (Splits)

| Key | Action | Source |
|-----|--------|--------|
| `Prefix + |` | Split pane horizontally (side-by-side) | **Custom** |
| `Prefix + -` | Split pane vertically (top-and-bottom) | **Custom** |
| `Prefix + h` | Select pane to the left (Vim style) | **Custom** |
| `Prefix + j` | Select pane below (Vim style) | **Custom** |
| `Prefix + k` | Select pane above (Vim style) | **Custom** |
| `Prefix + l` | Select pane to the right (Vim style) | **Custom** |
| `Prefix + H` | Resize pane left (5 units) | **Custom** |
| `Prefix + J` | Resize pane down (5 units) | **Custom** |
| `Prefix + K` | Resize pane up (5 units) | **Custom** |
| `Prefix + L` | Resize pane right (5 units) | **Custom** |
| `Prefix + z` | Toggle pane zoom (maximize) | Default |
| `Prefix + x` | Kill current pane | Default |
| `Prefix + {` | Swap current pane with previous | Default |
| `Prefix + }` | Swap current pane with next | Default |
| `Prefix + q` | Show pane numbers | Default |

## Copy Mode (Vi-style)

| Key | Action | Source |
|-----|--------|--------|
| `Prefix + Enter` | Enter copy mode | **Custom** |
| `Prefix + [` | Enter copy mode (default key) | Default |
| `v` | Begin selection (in copy mode) | **Custom** |
| `y` | Copy selection and exit (in copy mode) | **Custom** |
| `Escape` | Cancel selection (in copy mode) | **Custom** |
| `Prefix + ]` | Paste buffer | Default |

---

*Note: Panes and windows are 1-indexed in this configuration.*
