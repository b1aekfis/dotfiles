#!/usr/bin/env pwsh

$script:log = @()

$pnpm_packages = @()
$pip_packages = @()
$homebrew_packages = @(
  "trash-cli",
  "tree"
)
$pacman_packages = @(
  "trash-cli",
  "tree"
)
$apt_packages = @(
  "trash-cli",
  "tree"
)

function IsPackageInstalled {
  param (
    [Parameter(Mandatory=$true)]
    [string]$PackageName,
    [Parameter(Mandatory=$true)]
    [string]$PackageType
  )

  switch ($PackageType) {
    "pip"      { return (pip show $PackageName 2>$null) }
    "brew"     { return (brew list $PackageName 2>$null) }
    "apt"      { return (dpkg -s $PackageName 2>$null) }
    "pacman"   { return (pacman -Q $PackageName 2>$null) }
    "pnpm"     { return ((pnpm list -g --depth=0) -match $PackageName) }
  }
}

function Install-Packages {
  param (
    [Parameter(Mandatory=$true)]
    [string]$PackageName,
    [Parameter(Mandatory=$true)]
    [string]$PackageType
  )

  # check package manager
  if (-not (Get-Command $PackageType -ErrorAction SilentlyContinue)) {
    $msg = "❌ $PackageType is not found, failed to install $PackageName..."
    Write-Output $msg
    $script:log += $msg
    return
  }

  # check package
  $isInstalled = IsPackageInstalled -PackageName $PackageName -PackageType $PackageType

  if ($isInstalled) {
    $msg = "✅ $PackageName is already installed."
    Write-Output $msg
    $script:log += $msg
    return
  }

  Write-Output "🟢 Installing $PackageName via $PackageType..."

  try {
    # installing
    switch ($PackageType) {
      "pip"      { pip install $PackageName }
      "brew"     { brew install $PackageName }
      "apt"      { sudo apt update && sudo apt install -y $PackageName }
      "pacman"   { sudo pacman -Syu --noconfirm $PackageName }
      "pnpm"     { pnpm add -g $PackageName }
    }

    # must be callback
    $isInstalled = IsPackageInstalled -PackageName $PackageName -PackageType $PackageType

    if ($isInstalled) {
      $msg = "✅ $PackageName installed successfully! ($PackageType)."
    }
    else {
      $msg = "❌ Failed to install $PackageName ($PackageType)."
    }

  } catch {
    $msg = "❌ An error occurred while installing $PackageName ($PackageType). Please try again manually."
  }

  Write-Output $msg
  $script:log += $msg
}

# install utils
$pnpm_packages | ForEach-Object { Install-Packages $_ "pnpm" }
$pip_packages | ForEach-Object { Install-Packages $_ "pip" }

if ($IsMacOS) {
  $homebrew_packages | ForEach-Object { Install-Packages $_ "brew" }
}
elseif ($PSVersionTable.OS -match "Debian|Ubuntu") {
  $apt_packages | ForEach-Object { Install-Packages $_ "apt" }
}
elseif ($PSVersionTable.OS -match "Arch") {
  $pacman_packages | ForEach-Object { Install-Packages $_ "pacman" }
}

Write-Host "`n---- Summary ----" -ForegroundColor Blue
Write-Output $script:log
