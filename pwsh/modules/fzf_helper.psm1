function Set-FZF_DEFAULT_COMMAND {
  param(
    [string]$engine = "fd",
    [string]$type = "f",
    [switch]$hidden,
    [switch]$follow
  )
  $cmd = "$engine --type $type"
  if ($hidden) {
    $cmd += " --hidden"
  }
  if ($follow) {
    $cmd += " --follow"
  }

  $env:FZF_DEFAULT_COMMAND = $cmd
}

function Get-FF { # Get: cd or open files (nvim) with Fzf
  param (
    [switch]$worktree, # `ff -w` take from root when inside work tree
    [switch]$jump # `ff -j`
  )

  $type = if (-not $jump) { "f" } else { "d" }
  Set-FZF_DEFAULT_COMMAND -Type $type -Hidden -Follow

  # cd
  if ($jump) {
    $dir = if ($worktree) { # -w -j
      if ($(git rev-parse --is-inside-work-tree)) {
        $git_root = git rev-parse --show-toplevel
        iex "$env:FZF_DEFAULT_COMMAND . $git_root" | ForEach-Object {
          $_.Substring($git_root.Length).TrimStart('\', '/')
        } | fzf
      }
    }
    else { fzf } # -j

    Set-FZF_DEFAULT_COMMAND -Hidden -Follow # revert to default

    if ($dir) {
      if ($git_root) { cd $git_root }
      cd $dir
    }
    return
  }

  # open files
  $file = if ($worktree) { # -w
    if ($(git rev-parse --is-inside-work-tree)) {
      $git_root = git rev-parse --show-toplevel
      git ls-files --exclude-standard --cached --others --full-name $git_root | fzf --preview "bat --color=always --plain $git_root/{}"
    }
  }
  else { fzf }

  if ($file) {
    if ($git_root) { cd $git_root }
    nvim $file
  }
}
