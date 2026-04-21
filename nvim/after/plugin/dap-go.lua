local ok, dap_go = pcall(require, 'dap-go')
if not ok then
  vim.notify("dap-go not found", vim.log.levels.WARN)
  return
end

dap_go.setup()

local dap = require('dap')

-- Set custom configurations only
dap.configurations.go = {
  {
    type = "go",
    name = "Run server",
    request = "launch",
    program = ".",
    cwd = "${workspaceFolder}",
  },
  {
    type = "go",
    name = "Attach to process",
    request = "attach",
    mode = "local",
    processId = function()
      return require('dap.utils').pick_process()
    end,
  },
  {
    type = "go",
    name = "Run file",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
