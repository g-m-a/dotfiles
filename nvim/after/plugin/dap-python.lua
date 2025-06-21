-- Setup Python debugging adapter with error handling
local ok_dap, dap = pcall(require, 'dap')
if not ok_dap then
  vim.notify('DAP not installed, skipping Python DAP setup', vim.log.levels.WARN)
  return
end

local ok_dap_python, dap_python = pcall(require, 'dap-python')
if not ok_dap_python then
  vim.notify('dap-python not installed, skipping Python DAP setup', vim.log.levels.WARN)
  return
end

local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
if python_path == "" then
  vim.notify("Python executable not found. Please install Python or add it to PATH.", vim.log.levels.WARN)
  return
end

dap_python.setup(python_path)

-- Add test configurations
dap_python.test_runner = 'pytest'

-- Create configurations for Django
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Django',
  program = '${workspaceFolder}/manage.py',
  args = {'runserver', '--noreload'},
  justMyCode = true,
  django = true,
  console = "integratedTerminal",
})

-- Create configuration for FastAPI
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'FastAPI',
  module = 'uvicorn',
  args = {
    'main:app',
    '--reload',
  },
  jinja = true,
  justMyCode = true,
  console = "integratedTerminal",
})

-- Keymappings
vim.keymap.set('n', '<leader>dpt', function() dap_python.test_method() end, { desc = "Debug Python Test Method" })
vim.keymap.set('n', '<leader>dpc', function() dap_python.test_class() end, { desc = "Debug Python Test Class" })
vim.keymap.set('n', '<leader>dpf', function() dap_python.test_file() end, { desc = "Debug Python Test File" })