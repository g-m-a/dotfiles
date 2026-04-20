local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")

if not ok_dap then
  vim.notify("DAP not found, skipping DAP-UI setup", vim.log.levels.WARN)
  return
end

if not ok_dapui then
  vim.notify("DAP-UI not found, skipping DAP-UI setup", vim.log.levels.WARN)
  return
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override the default layouts
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "⏸",
      play = "▶",
      step_into = "⏎",
      step_over = "⏭",
      step_out = "⏮",
      step_back = "b",
      run_last = "▶▶",
      terminate = "⏹",
      disconnect = "⏏",
    },
  },
  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

-- Set up listeners to automatically open and close the windows
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Set up DAP signs
if dap.session then -- Check if dap is properly loaded
  dap.set_log_level("TRACE")
end

-- Note: DAP signs are now configured in nvim/after/plugin/signs.lua

-- Key mappings for DAP
vim.keymap.set('n', '<leader>db', function()
  if ok_dap then dap.toggle_breakpoint() end
end, { desc = "Toggle Breakpoint" })

vim.keymap.set('n', '<leader>dB', function()
  if ok_dap then dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end
end, { desc = "Set Conditional Breakpoint" })

vim.keymap.set('n', '<leader>dl', function()
  if ok_dap then dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end
end, { desc = "Set Log Point" })

vim.keymap.set('n', '<F5>', function()
  if ok_dap then dap.continue() end
end, { desc = "Continue" })

vim.keymap.set('n', '<F10>', function()
  if ok_dap then dap.step_over() end
end, { desc = "Step Over" })

vim.keymap.set('n', '<F11>', function()
  if ok_dap then dap.step_into() end
end, { desc = "Step Into" })

vim.keymap.set('n', '<F12>', function()
  if ok_dap then dap.step_out() end
end, { desc = "Step Out" })

vim.keymap.set('n', '<leader>dr', function()
  if ok_dap then dap.repl.open() end
end, { desc = "Open REPL" })

vim.keymap.set('n', '<leader>dt', function()
  if ok_dap then dap.terminate() end
end, { desc = "Terminate" })

vim.keymap.set('n', '<leader>du', function()
  if ok_dapui then dapui.toggle() end
end, { desc = "Toggle UI" })

-- Add session event listeners for debugging
-- dap.listeners.after.event_initialized["debug_session"] = function(session)
--   print("DAP session initialized: " .. (session.config.name or "unknown"))
-- end
--
-- dap.listeners.after.event_terminated["debug_session"] = function(session, body)
--   print("DAP session terminated: " .. (session.config.name or "unknown"))
--   if body and body.reason then
--     print("Termination reason: " .. body.reason)
--   end
-- end
--
-- dap.listeners.after.event_exited["debug_session"] = function(session, body)
--   print("DAP session exited: " .. (session.config.name or "unknown"))
--   if body and body.exitCode then
--     print("Exit code: " .. body.exitCode)
--   end
-- end
--
-- -- Enable DAP logging
-- dap.set_log_level('TRACE')
--
