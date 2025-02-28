#!/usr/bin/env pwsh

$windows_modules = @(
  "PSTree"
)
$cross_modules = @()

function Install-Modules($modules) {
  foreach($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
      try {
        Install-Module $module -Scope CurrentUser -Force -ErrorAction Stop
        Write-Host "Successfully installed: $module" -ForegroundColor Green
      } catch {
        Write-Host "Failed to install $module. Please install it manually." -ForegroundColor Red
      }
    }
  }
}
if ($IsWindows) {
  Install-Modules $windows_modules
}

Install-Modules $cross_modules
