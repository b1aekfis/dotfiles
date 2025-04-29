local editor = {}
editor.color = require 'editor.color'

-- Color codes inspection
local colorCodesInspectActive = false
local didTriggerCCInspect = {}

vim.api.nvim_create_user_command("ColorCodesInspect", function() -- toggle on/off
  colorCodesInspectActive = not colorCodesInspectActive
  if colorCodesInspectActive then
    print("ColorCodesInspect: ON")
    editor.color.linear_inspect()
    didTriggerCCInspect[vim.api.nvim_get_current_buf()] = true
  else
    print("ColorCodesInspect: OFF")
    for bufnr in pairs(didTriggerCCInspect) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        editor.color.stop_linear_inspect(bufnr)
      end
    end
    didTriggerCCInspect = {}
  end
end, {})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufWritePost" }, { -- trigger
  callback = function(args)
    if not colorCodesInspectActive then return end
    local bufnr = args.buf
    if args.event ~= "BufWritePost" then
      if didTriggerCCInspect[bufnr] then return end
      didTriggerCCInspect[bufnr] = true
    end
    editor.color.linear_inspect()
  end
})
