# =============================================================================
# windows/packages.ps1  —  Minimal bootstrap for WSL-first workflow
# Run as Administrator in PowerShell
# =============================================================================

#Requires -RunAsAdministrator
#Requires -Version 7.0

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "Relaunching under PowerShell 7..." -ForegroundColor Yellow
    & pwsh -NoProfile -ExecutionPolicy Bypass -File $MyInvocation.MyCommand.Path @args
    exit $LASTEXITCODE
}


$packages = @(
    # Core Infrastructure
    @{ Id = "Git.Git";                    Name = "Git" },
    @{ Id = "Microsoft.WindowsTerminal";  Name = "Windows Terminal (Ships with Win 11, may need install on Win 10)" },
    @{ Id = "DEVCOM.JetBrainsMonoNerdFont"; Name = "JetBrains Mono Nerd Font" },

    # Management
    @{ Id = "twpayne.chezmoi";            Name = "chezmoi" },
    @{ Id = "FiloSottile.age";           Name = "age (decryption for chezmoi)" }
)

$failed = @()

foreach ($pkg in $packages) {
    Write-Host "Checking $($pkg.Name)..." -ForegroundColor Cyan
    
    # Check if already installed
    $null = winget list --id $pkg.Id -e --source winget 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  $($pkg.Name) is already installed. Skipping." -ForegroundColor Green
        continue
    }

    Write-Host "  Installing $($pkg.Name)..." -ForegroundColor Cyan
    $result = winget install --id $pkg.Id --silent --accept-package-agreements --accept-source-agreements 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to install $($pkg.Name)"
        $failed += $pkg.Name
    }
}

Write-Host ""
if ($failed.Count -gt 0) {
    Write-Warning "The following packages failed to install:"
    $failed | ForEach-Object { Write-Warning "  - $_" }
} else {
    Write-Host "All core Windows packages installed successfully." -ForegroundColor Green
}

Write-Host "Restart your terminal to pick up PATH changes." -ForegroundColor Yellow
