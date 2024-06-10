# Theme
Invoke-Expression (&starship init powershell)

# cd with fzf
function Get-FFCDir {
  $dir = fd --type d --hidden --follow | fzf --height 40%
  if($dir -ne $null) {
    cd $dir
  }
}

# open file with fzf (Vim)
function Get-FFVim {
  $file = fd --type f --hidden --follow | fzf --height 40%
  if($file -ne $null) {
    vim $file
  }
}

# treer <root> <.../output.txt>
function Get-Tree([string]$r, [string]$t) {
  ~\.dotfiles\treer\main.exe $r $t
}

# make symlink
function Set-Symlink($link,$target) {
  ni -itemtype symboliclink -path $link -target $target
}

# make symlink with -force
function Set-SymlinkForce($link,$target) {
  ni -itemtype symboliclink -path $link -target $target -force
}

# Aliases
Set-Alias -Name vim -Value nvim
Set-Alias -Name ffim -Value Get-FFVim

New-Alias -Name ffcd -Value Get-FFCDir

New-Alias -Name treer -Value Get-Tree

New-Alias -Name trash -Value Remove-ItemSafely

New-Alias -Name nisl -Value Set-Symlink
New-Alias -Name nislf -Value Set-SymlinkForce

Remove-Alias -Name gi -Force
Remove-Alias -Name gc -Force
Remove-Alias -Name gp -Force
Remove-Alias -Name gl -Force
function Get-GitInit{& git init $args}
New-Alias -Name gi -Value Get-GitInit
function Get-Status{& git status $args}
New-Alias -Name gs -Value Get-Status
function Get-GitAdd{& git add $args}
New-Alias -Name ga -Value Get-GitAdd
function Get-GitCommit{& git commit $args}
New-Alias -Name gc -Value Get-GitCommit
function Get-GitPush{& git push $args}
New-Alias -Name gp -Value Get-GitPush
function Get-GitLog{& git log $args}
New-Alias -Name gl -Value Get-GitLog
function Get-GitStash{& git stash $args}
New-Alias -Name gst -Value Get-GitStash
function Get-GitFetch{& git fetch $args}
New-Alias -Name gf -Value Get-GitFetch
function Get-GitMerge{& git merge $args}
New-Alias -Name gmg -Value Get-GitMerge
function Get-GitReset{& git reset $args}
New-Alias -Name grs -Value Get-GitReset

# VIRTUAL_ENV_DISABLE_PROMPT
$env:VIRTUAL_ENV_DISABLE_PROMPT=1

# PSReadLine
$PSReadLineOptions = @{
  EditMode = "Vi"
  BellStyle = "None"
}
Set-PSReadLineOption @PSReadLineOptions

# PSStyle
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.FromRgb(0x3a94c4)
$PSStyle.Formatting.TableHeader = "$($PSStyle.Formatting.TableHeader)$($PSStyle.BoldOff)$($PSStyle.Italic)"
