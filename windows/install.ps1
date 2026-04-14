# windows/install.ps1  —  Minimal bootstrap for WSL-first workflow
# This script installs core management tools on Windows and sets up Zsh in WSL.
# Run as Administrator in PowerShell 7+:
#   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#   .\windows\install.ps1
# =============================================================================

param(
    [string]$DotfilesRepo = "https://github.com/jmacj/dotfiles.git"
)

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "Relaunching under PowerShell 7..." -ForegroundColor Yellow
    & pwsh -NoProfile -ExecutionPolicy Bypass -File $MyInvocation.MyCommand.Path @args
    exit $LASTEXITCODE
}


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

# ---- Install Zsh in WSL -----------------------------------------------------
function Install-ZshInWSL {
    Write-Info "Checking for WSL..."
    $wslCheck = wsl.exe --list 2>$null
    if ($null -ne $wslCheck) {
        Write-Info "WSL detected. Installing Zsh inside default distribution..."
        wsl.exe -- bash -c "sudo apt-get update && sudo apt-get install -y zsh && chsh -s \$(which zsh) \$USER"
        Write-Success "Zsh installed and set as default in WSL. Restart your WSL session to see changes."
    } else {
        Write-Warn "WSL not found or not initialized. Skipping Zsh installation."
    }
}

# ---- Main -------------------------------------------------------------------
Write-Info "Starting dotfiles bootstrap for Windows..."
Install-Chezmoi
Apply-Dotfiles
Install-Packages
Install-ZshInWSL
Write-Success "Bootstrap complete! Restart your terminal."
