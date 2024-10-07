# =======
# Aliases
# =======

New-Alias -Name trash -Value Remove-ItemSafely

# =======================================================================================================
# refactor the directory structure graphics printed by the "tree" command with "/a" parameter on Windows:
# gtree <root_path> <tree_path\file_name.txt>
# =======================================================================================================

function Get-Tree([string]$root_path, [string]$tree_path){
    ~\.dotfiles\gtree\gtree.exe $root_path $tree_path
}
New-Alias -Name gtree -Value Get-Tree

# ===================================================
# nisl and nisl_force to create symlink:
# nisl "<symlink_location>" "<target_location>"
# or
# nisl_force "<symlink_location>" "<target_location>"
# ===================================================

function Set-SymLink([string]$symlinkLoc,[string]$targetLoc){
    ni -itemtype symboliclink -path "$symlinkLoc" -value "$targetLoc" 
}
function Set-SymLink-Force([string]$symlinkLoc,[string]$targetLoc){ 
    ni -itemtype symboliclink -path "$symlinkLoc" -value "$targetLoc" -force
}
New-Alias -Name nisl -Value Set-SymLink #ni symlink
New-Alias -Name nisl_force -Value Set-SymLink-Force #ni symlink (-force)

# ============================================================================================================================
# the command to setup a shell prompt theme for PowerShell with Oh My Posh engine:
# oh-my-posh init pwsh --config '<point it to the location of a predefined theme or custom configuration>' | Invoke-Expression

# with a URL pointing to a remote config:
# oh-my-posh init pwsh --config '<a URL pointing to a remote config>' | Invoke-Expression

# with a path to a local configuration file:
# oh-my-posh init pwsh --config '<a path to a local configuration file>' | Invoke-Expression
# ============================================================================================================================

oh-my-posh init pwsh --config 'C:\Users\QUI\.dotfiles\omp\themes\evfrHp.omp.json' | Invoke-Expression

# ==========================
# VIRTUAL_ENV_DISABLE_PROMPT
# ==========================

$env:VIRTUAL_ENV_DISABLE_PROMPT=1

# ===========
# Git Aliases
# ===========

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

# ==========
# PSReadLine 
# ==========

$PSReadLineOptions = @{
    EditMode = "Vi"
    BellStyle = "None"
}
Set-PSReadLineOption @PSReadLineOptions