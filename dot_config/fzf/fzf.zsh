# =============================================================================
# ~/.config/fzf/fzf.zsh  —  fzf key bindings and completion for Zsh
# =============================================================================

if command -v fzf &>/dev/null; then
  # Load from Homebrew (macOS) or system install (Linux)
  if command -v brew &>/dev/null; then
    _fzf_base="$(brew --prefix fzf 2>/dev/null)"
    [ -f "${_fzf_base}/shell/key-bindings.zsh" ] && source "${_fzf_base}/shell/key-bindings.zsh"
    [ -f "${_fzf_base}/shell/completion.zsh" ]   && source "${_fzf_base}/shell/completion.zsh"
  elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  elif [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
fi
