#!/usr/bin/env bash
# =============================================================================
# install.sh  —  Bootstrap dotfiles on macOS / Linux
# Usage:
#   # One-liner (no repo cloned yet):
#   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/jmacj/dotfiles.git
#
#   # If repo is already cloned:
#   bash ~/dotfiles/install.sh
#
# SECURITY NOTE: The one-liner above downloads and executes a remote script.
# To verify before running, inspect https://get.chezmoi.io first, or install
# chezmoi manually from https://github.com/twpayne/chezmoi/releases and then
# run: chezmoi init --apply https://github.com/jmacj/dotfiles.git
# =============================================================================

set -euo pipefail
umask 022

DOTFILES_REPO="${1:-https://github.com/jmacj/dotfiles.git}"
CHEZMOI_BIN="$HOME/.local/bin/chezmoi"

info()    { printf "\033[0;34m[INFO]\033[0m  %s\n" "$*"; }
success() { printf "\033[0;32m[OK]\033[0m    %s\n" "$*"; }
warn()    { printf "\033[0;33m[WARN]\033[0m  %s\n" "$*"; }
die()     { printf "\033[0;31m[ERROR]\033[0m %s\n" "$*" >&2; exit 1; }

# Exit with a clear error message if any command fails unexpectedly
trap 'die "Script failed on line ${LINENO:-?}"' ERR

# ---- Install chezmoi if missing ---------------------------------------------
install_chezmoi() {
  if command -v chezmoi &>/dev/null; then
    success "chezmoi already installed: $(chezmoi --version)"
    return
  fi

  info "Installing chezmoi..."
  mkdir -p "$HOME/.local/bin"

  if command -v brew &>/dev/null; then
    brew install chezmoi
  else
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
  fi

  export PATH="$HOME/.local/bin:$PATH"
  success "chezmoi installed."
}

# ---- Apply dotfiles ---------------------------------------------------------
apply_dotfiles() {
  if chezmoi source-path &>/dev/null 2>&1; then
    info "chezmoi already initialised. Running chezmoi apply..."
    chezmoi apply
  else
    info "Initialising chezmoi from $DOTFILES_REPO ..."
    chezmoi init --apply "$DOTFILES_REPO"
  fi
  success "Dotfiles applied."
}

# ---- macOS: install Homebrew dependencies -----------------------------------
install_macos_deps() {
  if [[ "$(uname)" != "Darwin" ]]; then return; fi

  if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  local brewfile
  brewfile="$(chezmoi source-path)/macos/Brewfile"
  if [ -f "$brewfile" ]; then
    info "Installing Homebrew packages from Brewfile..."
    brew bundle --file="$brewfile"
    success "Homebrew packages installed."
  fi
}

# ---- Linux: install local dependencies (non-sudo) ---------------------------
install_linux_deps() {
  if [[ "$(uname)" != "Linux" ]]; then return; fi

  local pkg_script
  pkg_script="$(chezmoi source-path)/linux/packages.sh"
  if [ -f "$pkg_script" ]; then
    info "Installing Linux packages..."
    bash "$pkg_script"
  else
    warn "Linux package script not found at $pkg_script"
  fi
}

# ---- Main -------------------------------------------------------------------
main() {
  info "Starting dotfiles bootstrap..."

  # Check dependencies
  for cmd in curl git sudo; do
    if ! command -v "$cmd" &>/dev/null; then
      die "Core dependency '$cmd' is not installed. Please install it and try again."
    fi
  done

  # Secure sensitive files
  info "Securing sensitive directories and history files..."
  chmod 700 "$HOME/.ssh" "$HOME/.gnupg" 2>/dev/null || true
  for histfile in "$HOME/.bash_history" "$HOME/.zsh_history"; do
    if [[ -f "$histfile" ]]; then
      chmod 600 "$histfile"
    fi
  done

  install_chezmoi
  apply_dotfiles
  
  case "$(uname)" in
    Darwin) install_macos_deps ;;
    Linux)  install_linux_deps ;;
  esac

  success "Bootstrap complete! Restart your shell or run: exec \$SHELL -l"
}

main "$@"
