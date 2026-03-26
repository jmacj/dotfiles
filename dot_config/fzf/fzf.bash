# =============================================================================
# ~/.config/fzf/fzf.bash  —  fzf key bindings and completion for Bash
# =============================================================================

# Load fzf (installed via package manager or manually)
if command -v fzf &>/dev/null; then
  # Key bindings: Ctrl+R (history), Ctrl+T (files), Alt+C (cd)
  if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
  elif [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
  elif command -v brew &>/dev/null; then
    _fzf_base="$(brew --prefix fzf 2>/dev/null)"
    [ -f "${_fzf_base}/shell/key-bindings.bash" ] && source "${_fzf_base}/shell/key-bindings.bash"
    [ -f "${_fzf_base}/shell/completion.bash" ] && source "${_fzf_base}/shell/completion.bash"
  fi
fi
