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
    [switch]$repo, # ff -r
    [switch]$cd # ff -c
  )

  $type = if (-not $cd) { "f" } else { "d" }
  Set-FZF_DEFAULT_COMMAND -Type $type -Hidden -Follow

  # cd
  if ($cd) {
    $dir = if ($repo) { # -c -r
      if ($(git rev-parse --show-toplevel)) {
        $root = git rev-parse --show-toplevel
        $cmd = "$env:FZF_DEFAULT_COMMAND . $root"
        Invoke-Expression $cmd | ForEach-Object {
          $_.Substring($root.Length).TrimStart('\', '/')
        } | fzf
      }
    }
    else { fzf }

    if ($dir -ne $null) {
      if ($repo) { cd $(git rev-parse --show-toplevel) }
      cd $dir
    }
    return
  }

  # open files
  $file = if ($repo) {
    if ($(git rev-parse --show-toplevel)) {
      git ls-files --exclude-standard --cached --others --full-name $(git rev-parse --show-toplevel) | fzf
    }
  }
  else { fzf }

  if ($file -ne $null) {
    if ($repo) { cd $(git rev-parse --show-toplevel) }
    nvim $file
  }
}
