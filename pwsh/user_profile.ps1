# Theme
Invoke-Expression (&starship init powershell)

# Env
$env:VIRTUAL_ENV_DISABLE_PROMPT=1

# PSReadLine
$PSReadLineOptions = @{
  EditMode = "Vi"
  BellStyle = "None"
}
Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Chord "Ctrl+w" -Function BackwardKillWord
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function AcceptSuggestion # key accept the current inline suggestion

# PSStyle
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.FromRgb(0x3a94c4)

# Aliases 
Set-Alias -Name vim -Value nvim

Set-Alias -Name lzg -Value lazygit

Set-Alias -Name trash -Value Remove-ItemSafely

function Get-FFir { # Get: cd with Fzf
  # opts
  $dir = fd --type d --hidden --follow | fzf `
    --style minimal `
    --layout reverse `
    --height 40% `
    --pointer '>'

  if($dir -ne $null) {
    cd $dir
  }
}

function Get-FFim { # Get: open file with Fzf (Vim)
  # opts
  $file = fd --type f --hidden --follow | fzf `
    --style minimal `
    --layout reverse `
    --height 40% `
    --pointer '>' `
    --color 'spinner:#af5fff' `
    --multi `
    --bind 'F4:toggle-preview' `
    --preview-window ':hidden' `
    --preview 'bat --color=always --plain {}'

  if($file -ne $null) {
    vim $file
  }
}

function Get-Treer([string]$r, [string]$t) { # Get: treer <root> <.../tree.txt>
  ~\.dotfiles\treer\main.exe $r $t
}

function Set-Symlink($link,$target) { # Set: symlink
  ni -itemtype symboliclink -path $link -target $target
}
Set-Alias -Name nisl -Value Set-Symlink

function Set-SymlinkForce($link,$target) { # Set: symlink with -force
  ni -itemtype symboliclink -path $link -target $target -force
}
Set-Alias -Name nislf -Value Set-SymlinkForce

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
