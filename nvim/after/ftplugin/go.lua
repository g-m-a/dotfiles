-- Go-specific settings for proper indentation
vim.bo.expandtab = false  -- Use real tabs in Go files
vim.bo.tabstop = 4       -- Tab width is 4 spaces
vim.bo.shiftwidth = 4    -- Indentation is 4 spaces
vim.bo.softtabstop = 4   -- 4 spaces when pressing tab key

-- Handle tab behavior in insert mode for Go files
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*.go",
  callback = function()
    -- Make tab behave properly in Go files (doesn't jump weirdly)
    vim.keymap.set("i", "<Tab>", function()
      if require('cmp').visible() then
        -- If completion menu is visible, just navigate without inserting
        require('cmp').select_next_item({ behavior = require('cmp').SelectBehavior.Select })
      else
        -- Insert proper Go tab (actual tab character)
        return "<Tab>"
      end
    end, { expr = true, buffer = true })
  end
})