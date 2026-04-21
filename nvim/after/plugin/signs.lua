-- Set the highlights
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ea6962" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#d8a657" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#89b482" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#7daea3" })

-- PART 2: DAP (DEBUG ADAPTER PROTOCOL) SIGNS CONFIGURATION
-- Set up highlight groups for DAP signs
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff0000" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ff8800" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#00ffff" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ffff00" })
vim.api.nvim_set_hl(0, "DapRejected", { fg = "#ff0000" })

-- DAP signs must be defined using sign_define as they're not part of the diagnostic system
-- but we keep them in this file for consolidated sign management
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟠', texthl = 'DapBreakpointCondition' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = 'DapStopped', linehl = 'DapStoppedLine' })
vim.fn.sign_define('DapRejected', { text = '❌', texthl = 'DapRejected' })

-- PART 3: CONFIGURE DIAGNOSTIC DISPLAY WITH ALL SIGNS
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Could be "■", "▎", "x"
    source = "if_many",
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
  },
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
