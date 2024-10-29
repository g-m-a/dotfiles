require('illuminate').configure({
  -- Configuration options for vim-illuminate
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  delay = 100,
  filetypes_denylist = {
    'dirvish',
    'fugitive',
  },
  under_cursor = true,
})

-- Highlight groups for illuminated words
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = '#585858', underdotted = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = '#585858', underdotted = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = '#585858', underdotted = true })
