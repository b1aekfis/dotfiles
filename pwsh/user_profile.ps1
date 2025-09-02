# Env
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# XDG
if (-not $env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME = if ($IsWindows) { "$env:LOCALAPPDATA" } else { "$HOME/.config" } }
if (-not $env:XDG_DATA_HOME)   { $env:XDG_DATA_HOME   = if ($IsWindows) { "$env:LOCALAPPDATA" } else { "$HOME/.local/share" } }
if (-not $env:XDG_STATE_HOME)  { $env:XDG_STATE_HOME  = if ($IsWindows) { "$env:LOCALAPPDATA" } else { "$HOME/.local/state" } }
if (-not $env:XDG_CACHE_HOME)  { $env:XDG_CACHE_HOME  = if ($IsWindows) { "$env:TEMP" } else { "$HOME/.cache" } }

# PNPM_HOME
if (-not $env:PNPM_HOME) { $env:PNPM_HOME = "$env:XDG_DATA_HOME/pnpm" }

# PATH
$sepP = $IsWindows ? ';' : ':'

if ("$sepP$env:PATH$sepP" -notlike "*$sepP$env:PNPM_HOME$sepP*" ) {
  $env:PATH = "$env:PNPM_HOME$sepP$env:PATH"
}

# Include
if (Test-Path ~/private_profile.ps1) { . ~/private_profile.ps1 }

$dotfilesRoot = Split-Path -Parent (Get-Item $MyInvocation.MyCommand.Path).Target
Import-Module (Join-Path $dotfilesRoot "modules/fzf_helper.psm1")

# PSReadLine
$PSReadLineOptions = @{
  Colors = @{
    # default is InlinePrediction = "`e[97;2;3m"
    InlinePrediction = "$($PSStyle.Foreground.FromRgb(0x47503e))$($PSStyle.Italic)"
    Command = "#648f90"
    Parameter = "#648f90"
  }
  EditMode = "Vi"
  BellStyle = "None"
  ViModeIndicator = "Script"
  ViModeChangeHandler = {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
  }
}
Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Chord "Ctrl+w" -Function BackwardKillWord
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function AcceptSuggestion # key accept the current inline suggestion

# PSStyle
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.FromRgb(0x3a94c4)

# Theme
Invoke-Expression (&starship init powershell)

# Function
if ($IsWindows) {
  function trash { # remove items safely
    $shell = New-Object -ComObject Shell.Application
    $recycleBin = $shell.Namespace(10)

    foreach ($path in $args) {
      if (Test-Path $path) {
        $item = Get-Item $path
        $file = $shell.Namespace($item.DirectoryName).ParseName($item.Name)
        $recycleBin.MoveHere($file, 0)
      }
    }
  }

  function Set-Symlink { # Set: symlink
    param (
      [switch]$force,
      [Parameter(Mandatory=$true)]
      $link,
      [Parameter(Mandatory=$true)]
      $target
    )

    if ($force) { $isForce = $true } else { $isForce = $false }
    ni -Itemtype symboliclink -Path $link -Target $target -Force:$isForce
  }
  Set-Alias -Name nisl -Value Set-Symlink
}

function vim { # nvim
  if ($args) {
    & nvim --headless $args -c qall
    if ($LASTEXITCODE -ne 0) { return }
  }

  while ($true) {
    & nvim $args
    if ($LASTEXITCODE -eq 0) { break }
    Write-Host "Restarting Neovim..." -ForegroundColor Yellow
  }
}

# ZO
$env:_ZO_FZF_OPTS=$env:FZF_DEFAULT_OPTS
Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) })
function jr { zoxide remove $(zoxide query -l | fzf) }

# Aliases
Set-Alias -Name lzg -Value lazygit

function Get-GitDifftool{& git difftool $args}
Set-Alias -Name gdt -Value Get-GitDifftool

function Get-GitStatus{& git status $args}
Set-Alias -Name gs -Value Get-GitStatus

function Get-GitAdd{& git add $args}
Set-Alias -Name ga -Value Get-GitAdd

function Get-GitCommit{& git commit $args}
Set-Alias -Name gc -Value Get-GitCommit -Force

function Get-GitPush{& git push $args}
Set-Alias -Name gp -Value Get-GitPush -Force

function Get-GitLog{& git log $args}
Set-Alias -Name gl -Value Get-GitLog -Force

function Get-GitStash{& git stash $args}
Set-Alias -Name gst -Value Get-GitStash

function Get-GitFetch{& git fetch $args}
Set-Alias -Name gf -Value Get-GitFetch

function Get-GitMerge{& git merge $args}
Set-Alias -Name gmg -Value Get-GitMerge
