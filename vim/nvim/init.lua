-- for toggleterm
local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end

-- master
require("config.options")
require("config.keymaps")
require("config.lazy")

vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[hi EndOfBuffer guibg=NONE ctermbg=NONE]])
vim.cmd([[hi CursorLine guibg=#3c4841 ctermbg=NONE]])
vim.cmd([[hi CursorLineNr guibg=NONE guifg=#a7c080]])
vim.cmd([[hi normalNC guibg=NONE ctermbg=NONE]])
