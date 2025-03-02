# Env
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
$env:FZF_DEFAULT_OPTS = "
  --style minimal
  --layout reverse
  --height 40%
  --pointer '>'
  --color 'spinner:#af5fff'
  --multi
  --bind 'F4:toggle-preview'
  --preview-window ':hidden'
  --preview 'bat --color=always --plain {}'
  "

# PSReadLine
$PSReadLineOptions = @{
  Colors = @{
    # default is InlinePrediction = "`e[97;2;3m"
    InlinePrediction = "$($PSStyle.Foreground.FromRgb(0x707070))$($PSStyle.Italic)"
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
  function trash {
    param(
      [Parameter(Mandatory=$true)]
      [string]$path
    )

    $shell = New-Object -ComObject Shell.Application
    $file = $shell.Namespace((Get-Item $path).DirectoryName).ParseName((Get-Item $path).Name)
    $recycleBin = $shell.Namespace(10)
    $recycleBin.MoveHere($file, 0)
  }
}

function Get-FFir { # Get: cd with Fzf
  $dir = fd --type d --hidden --follow | fzf

  if ($dir -ne $null) {
    cd $dir
  }
}

function Get-FFim { # Get: open file with Fzf (nvim)
  param (
    [switch]$git # ffim -g
  )

  $file = if ($git) {
    if ($(git root)) {
      git ls-files --exclude-standard --cached --others --full-name $(git root) | fzf
    }
  }
  else {
    fd --type f --hidden --follow | fzf
  }

  if ($file -ne $null) {
    if ($git) { cd $(git root) }
    nvim $file
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

# Aliases
Set-Alias -Name vim -Value nvim

Set-Alias -Name lzg -Value lazygit

function Get-GitDifftool($file){git difftool $file} # Get: git difftool arg1, arg2, ...
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
