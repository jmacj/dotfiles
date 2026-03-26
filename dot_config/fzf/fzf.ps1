# =============================================================================
# ~/.config/fzf/fzf.ps1  —  fzf key bindings for PowerShell
# Requires PSFzf module: Install-Module -Name PSFzf
# =============================================================================

if (Get-Command fzf -ErrorAction SilentlyContinue) {
    # PSFzf must be installed via: Install-Module -Name PSFzf -Scope CurrentUser
    Import-Module PSFzf -ErrorAction SilentlyContinue

    if (Get-Module PSFzf) {
        # Override Ctrl+T (file search) and Ctrl+R (history search)
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

        # Alt+C: cd into selected directory
        Set-PSReadLineKeyHandler -Chord 'Alt+c' -ScriptBlock { Invoke-FzfTabCompletion }
    }
}
