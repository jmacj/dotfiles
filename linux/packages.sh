#!/usr/bin/env bash
# =============================================================================
# linux/packages.sh  —  Install dev tools on Linux without sudo
# Installs binaries to ~/.local/bin
# =============================================================================

set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

# Add local bin to PATH for the current session
export PATH="$BIN_DIR:$PATH"

info()    { printf "\033[0;34m[INFO]\033[0m  %s\n" "$*"; }
success() { printf "\033[0;32m[OK]\033[0m    %s\n" "$*"; }
warn()    { printf "\033[0;33m[WARN]\033[0m  %s\n" "$*"; }
error()   { printf "\033[0;31m[ERROR]\033[0m %s\n" "$*" >&2; }

# Helper to download from GitHub releases
# Usage: download_gh_release "owner/repo" "pattern" "output_name"
download_gh_release() {
  local repo=$1
  local pattern=$2
  local output=$3

  if command -v "$output" &>/dev/null; then
    success "$output already installed."
    return
  fi

  info "Installing $output from $repo..."
  local url
  url=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | \
    grep "browser_download_url" | \
    grep -iE "$pattern" | \
    grep -ivE "\.sha256|\.sig|\.asc|\.checksum" | \
    cut -d '"' -f 4 | \
    head -n 1)

  if [ -z "$url" ]; then
    error "Could not find a suitable download URL for $output (pattern: $pattern)"
    return 1
  fi

  local tmp_dir
  tmp_dir=$(mktemp -d)
  curl -fsSL "$url" -o "$tmp_dir/archive"

  if [[ "$url" == *.tar.gz ]]; then
    tar -xzf "$tmp_dir/archive" -C "$tmp_dir"
  elif [[ "$url" == *.tar.xz ]]; then
    tar -xJf "$tmp_dir/archive" -C "$tmp_dir"
  elif [[ "$url" == *.zip ]]; then
    unzip -oq "$tmp_dir/archive" -d "$tmp_dir"
  else
    # Treat as direct binary download
    mv "$tmp_dir/archive" "$tmp_dir/$output"
    chmod +x "$tmp_dir/$output"
  fi

  # Find the binary. We look for:
  # 1. A file named exactly $output
  # 2. Any executable file if (1) fails
  local binary_path
  binary_path=$(find "$tmp_dir" -type f -name "$output" -executable -print -quit)
  if [ -z "$binary_path" ]; then
    binary_path=$(find "$tmp_dir" -type f -executable -print -quit)
  fi

  if [ -n "$binary_path" ]; then
    mv "$binary_path" "$BIN_DIR/$output"
    chmod +x "$BIN_DIR/$output"
    success "$output installed."
  else
    error "Could not find an executable for $output in the downloaded package."
    return 1
  fi
  
  rm -rf "$tmp_dir"
}

# ---- Tool Installations -----------------------------------------------------

# Starship prompt
if ! command -v starship &>/dev/null; then
  info "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$BIN_DIR"
  success "Starship installed."
fi

# FZF
if ! command -v fzf &>/dev/null; then
  info "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --bin
  cp ~/.fzf/bin/fzf "$BIN_DIR/"
  success "fzf installed."
fi

# Tools via GitHub Releases (x86_64 focus)
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  # ripgrep
  download_gh_release "BurntSushi/ripgrep" "x86_64-unknown-linux-musl.tar.gz" "rg"
  # bat
  download_gh_release "sharkdp/bat" "x86_64-unknown-linux-musl.tar.gz" "bat"
  # fd
  download_gh_release "sharkdp/fd" "x86_64-unknown-linux-musl.tar.gz" "fd"
  # eza
  download_gh_release "eza-community/eza" "x86_64-unknown-linux-gnu.tar.gz" "eza"
  # delta
  download_gh_release "dandavison/delta" "x86_64-unknown-linux-musl.tar.gz" "delta"
  # gh (GitHub CLI)
  download_gh_release "cli/cli" "linux_amd64.tar.gz" "gh"
  # yq
  download_gh_release "mikefarah/yq" "yq_linux_amd64.tar.gz" "yq"
  # age
  download_gh_release "FiloSottile/age" "linux-amd64.tar.gz" "age"
  # shellcheck
  download_gh_release "koalaman/shellcheck" "linux.x86_64.tar.xz" "shellcheck"
  # shfmt
  download_gh_release "mvdan/sh" "shfmt_.*_linux_amd64" "shfmt"
  # hadolint
  download_gh_release "hadolint/hadolint" "hadolint-Linux-x86_64" "hadolint"
  # git-lfs
  download_gh_release "git-lfs/git-lfs" "linux-amd64" "git-lfs"
  # jq
  download_gh_release "jqlang/jq" "jq-linux64" "jq"
fi

# NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
  info "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  success "nvm installed."
fi

# pnpm
if ! command -v pnpm &>/dev/null; then
  info "Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | SHELL="$(which bash)" sh -
  success "pnpm installed."
fi

# Check for essential tools that might require sudo
for tool in zsh git tmux make; do
  if ! command -v "$tool" &>/dev/null; then
    warn "Tool '$tool' is not installed and requires sudo to install via apt. Please contact your administrator."
  fi
done

info "Package installation complete."
warn "Please restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
