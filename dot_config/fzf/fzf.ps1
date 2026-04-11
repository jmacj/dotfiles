# =============================================================================
# ~/.config/fzf/fzf.ps1  —  fzf key bindings for PowerShell
# Requires PSFzf module: Install-Module -Name PSFzf
# =============================================================================

if (Get-Command fzf -ErrorAction SilentlyContinue) {
    # PSFzf must be installed via: Install-Module -Name PSFzf -Scope CurrentUser
    Import-Module PSFzf -ErrorAction SilentlyContinue

    if (Get-Module PSFzf) {
        # Enable default key bindings:
        # Ctrl+T (file search), Ctrl+R (history search), Alt+C (cd)
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
        Set-PSReadLineKeyHandler -Chord 'Alt+c' -ScriptBlock { Invoke-FzfDirectorySearch }
    }
}
