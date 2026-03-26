# =============================================================================
# windows/install.ps1  —  Bootstrap dotfiles on Windows
# Run as Administrator in PowerShell 7+:
#   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#   .\windows\install.ps1
# =============================================================================

param(
    [string]$DotfilesRepo = "https://github.com/jmacj/dotfiles.git"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Ensure child scripts can run in this process regardless of global system policy
if ($PSVersionTable.PSVersion.Major -ge 7) {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
}

function Write-Info    { Write-Host "[INFO]  $args" -ForegroundColor Cyan }
function Write-Success { Write-Host "[OK]    $args" -ForegroundColor Green }
function Write-Warn    { Write-Host "[WARN]  $args" -ForegroundColor Yellow }

# ---- Install chezmoi --------------------------------------------------------
function Install-Chezmoi {
    if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
        Write-Success "chezmoi already installed: $(chezmoi --version)"
        return
    }

    Write-Info "Installing chezmoi..."

    # Try winget first
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id twpayne.chezmoi --silent --accept-package-agreements --accept-source-agreements
    }
    # Fallback: direct download to temp file (avoids Invoke-Expression on remote content)
    else {
        $tmp = [System.IO.Path]::GetTempFileName() + ".ps1"
        Invoke-WebRequest -UseBasicParsing "https://get.chezmoi.io/ps1" -OutFile $tmp
        & $tmp
        Remove-Item $tmp -ErrorAction SilentlyContinue
    }

    Write-Success "chezmoi installed."
}

# ---- Apply dotfiles ---------------------------------------------------------
function Apply-Dotfiles {
    $chezmoiSource = & chezmoi source-path 2>$null

    if ($chezmoiSource) {
        Write-Info "chezmoi already initialised. Running chezmoi apply..."
        chezmoi apply
    } else {
        Write-Info "Initialising chezmoi from $DotfilesRepo ..."
        chezmoi init --apply $DotfilesRepo
    }

    Write-Success "Dotfiles applied."
}

# ---- Install packages -------------------------------------------------------
function Install-Packages {
    $packagesScript = Join-Path (chezmoi source-path) "windows\packages.ps1"
    if (Test-Path $packagesScript) {
        Write-Info "Installing packages via Winget..."
        & $packagesScript
    }
}

# ---- Main -------------------------------------------------------------------
Write-Info "Starting dotfiles bootstrap for Windows..."
Install-Chezmoi
Apply-Dotfiles
Install-Packages
Write-Success "Bootstrap complete! Restart your terminal."
