-- Go-specific settings for proper indentation
vim.bo.expandtab = false -- Use real tabs in Go files
vim.bo.tabstop = 4       -- Tab width is 4 spaces
vim.bo.shiftwidth = 4    -- Indentation is 4 spaces
vim.bo.softtabstop = 4   -- 4 spaces when pressing tab key

-- Tab behavior is now handled properly by the main cmp configuration
-- No need for Go-specific Tab overrides that cause conflicts


vim.keymap.set('n', '<F8>', function() require('dap-go').debug_test() end)
