require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Key mappings for DAP
vim.keymap.set('n', '<C-b>', function() require 'dap'.toggle_breakpoint() end)
vim.keymap.set('n', '<C-c>', function() require 'dap'.continue() end)
vim.keymap.set('n', '<C-\'>', function() require 'dap'.step_over() end)
vim.keymap.set('n', '<C-;>', function() require 'dap'.step_into() end)
vim.keymap.set('n', '<C-:>', function() require 'dap'.step_out() end)
