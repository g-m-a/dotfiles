-- Setup modern diagnostic signs
local diagnostic_signs = {
  { name = "DiagnosticSignError", text = " ", texthl = "DiagnosticSignError" },
  { name = "DiagnosticSignWarn",  text = " ", texthl = "DiagnosticSignWarn" },
  { name = "DiagnosticSignHint",  text = " ", texthl = "DiagnosticSignHint" },
  { name = "DiagnosticSignInfo",  text = " ", texthl = "DiagnosticSignInfo" },
}

-- Set the highlights
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ea6962" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#d8a657" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#89b482" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#7daea3" })

-- Create the signs configuration for diagnostic signs
local diagnostic_signs_config = {}
for _, sign in ipairs(diagnostic_signs) do
  diagnostic_signs_config[vim.diagnostic.severity[sign.name:match("DiagnosticSign(%u%l+)")] or 0] = {
    text = sign.text,
    texthl = sign.texthl,
    numhl = sign.texthl,
  }
end

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
    active = diagnostic_signs_config,
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

