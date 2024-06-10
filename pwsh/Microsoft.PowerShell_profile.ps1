# Theme
Invoke-Expression (&starship init powershell)

# _vdff (_vdiff) m1, m2, ...
function Get-Vdff([string]$m) {
    wt -w 0 -p pwsh -d . pwsh -c git difftool $m
}

# treer <root> <.../output.txt>
function Get-Tree([string]$r, [string]$t){
    ~\.dotfiles\treer\main.exe $r $t
}

# nisl "<../location>" "<../target/location>"
function Set-SymLink([string]$loc,[string]$targetLoc){
    ni -itemtype symboliclink -path "$loc" -value "$targetLoc"
}

# nislf "<../location>" "<../target/location>"
function Set-SymLink-Force([string]$loc,[string]$targetLoc){
    ni -itemtype symboliclink -path "$loc" -value "$targetLoc" -force
}

# Aliases
New-Alias -Name _vdff -Value Get-Vdff
New-Alias -Name _vdiff -Value Get-Vdff
New-Alias -Name treer -Value Get-Tree
New-Alias -Name nisl -Value Set-SymLink
New-Alias -Name nislf -Value Set-SymLink-Force
Set-Alias -Name vim -Value nvim
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
function Get-GitDiffTool{& git difftool $args}
New-Alias -Name vdff -Value Get-GitDiffTool
New-Alias -Name vdiff -Value Get-GitDiffTool
New-Alias -Name trash -Value Remove-ItemSafely

# VIRTUAL_ENV_DISABLE_PROMPT
$env:VIRTUAL_ENV_DISABLE_PROMPT=1

# PSReadLine
$PSReadLineOptions = @{
    EditMode = "Vi"
    BellStyle = "None"
}
Set-PSReadLineOption @PSReadLineOptions

# ...
$PSStyle.FileInfo.Directory = ""
