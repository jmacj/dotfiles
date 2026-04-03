# =============================================================================
# windows/packages.ps1  —  Install common dev tools via Winget
# Run as Administrator in PowerShell
# =============================================================================

#Requires -RunAsAdministrator

$packages = @(
    # Shell & terminal
    @{ Id = "Git.Git";                    Name = "Git" },
    @{ Id = "Microsoft.WindowsTerminal";  Name = "Windows Terminal" },
    @{ Id = "Warp.Warp";                  Name = "Warp Terminal" },
    @{ Id = "Starship.Starship";          Name = "Starship prompt" },
    @{ Id = "dandavison.delta";           Name = "delta (Git pager)" },
    @{ Id = "DEVCOM.JetBrainsMonoNerdFont"; Name = "JetBrains Mono Nerd Font" },

    # Dev tools
    @{ Id = "twpayne.chezmoi";            Name = "chezmoi" },
    @{ Id = "GitHub.cli";                 Name = "GitHub CLI" },
    @{ Id = "BurntSushi.ripgrep.MSVC";    Name = "ripgrep" },
    @{ Id = "junegunn.fzf";              Name = "fzf" },
    @{ Id = "sharkdp.bat";               Name = "bat (cat replacement)" },
    @{ Id = "eza-community.eza";          Name = "eza (ls replacement)" },
    @{ Id = "sharkdp.fd";                Name = "fd (find replacement)" },
    @{ Id = "cURL.cURL";                 Name = "curl" },
    @{ Id = "GNU.Wget2";                Name = "wget2" },
    @{ Id = "jqlang.jq";                 Name = "jq (JSON)" },
    @{ Id = "MikeFarah.yq";              Name = "yq (YAML)" },
    @{ Id = "ezwinports.make";          Name = "make" },

    # Node & package managers
    @{ Id = "CoreyButler.NVMforWindows";  Name = "nvm-windows" },
    @{ Id = "pnpm.pnpm";                 Name = "pnpm" },

    # Security & Git
    @{ Id = "GnuPG.GnuPG";              Name = "GnuPG" },
    @{ Id = "FiloSottile.age";           Name = "age (encryption)" },
    @{ Id = "GitHub.GitLFS";             Name = "Git LFS" },

    # Linters & Formatters
    @{ Id = "koalaman.shellcheck";      Name = "shellcheck" },
    @{ Id = "mvdan.shfmt";              Name = "shfmt" },
    @{ Id = "hadolint.hadolint";        Name = "hadolint (Dockerfile linter)" }
)

$failed = @()

foreach ($pkg in $packages) {
    Write-Host "Checking $($pkg.Name)..." -ForegroundColor Cyan
    
    # Check if already installed
    # 'winget list' returns non-zero exit code if package is not found
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
    Write-Host "All Winget packages installed successfully." -ForegroundColor Green
}

# Install PSFzf module for PowerShell fzf integration
Write-Host ""
if (-not (Get-Module -ListAvailable PSFzf)) {
    Write-Host "Installing PSFzf module..." -ForegroundColor Cyan
    Install-Module -Name PSFzf -Scope CurrentUser -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
    if ($LASTEXITCODE -eq 0 -or (Get-Module -ListAvailable PSFzf)) {
        Write-Host "  PSFzf installed." -ForegroundColor Green
    } else {
        Write-Warning "Failed to install PSFzf module. You may need to run: Install-Module PSFzf"
    }
} else {
    Write-Host "PSFzf module is already installed." -ForegroundColor Green
}

Write-Host "Restart your terminal to pick up PATH changes." -ForegroundColor Yellow
