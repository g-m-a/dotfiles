-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load plugins
require('plugins')

-- Load keymaps
require('keymaps')

-- Load core settings
require('settings')

-- Load LSP configuration
require('lsp_config')

-- Load Treesitter configuration
require('treesitter_config')

-- Load Telescope configuration
require('telescope_config')

-- Load statusline configuration
require('statusline_config')

-- Load Gitsigns configuration
require('gitsigns_config')

-- Load Copilot configuration
require('copilot_config')

-- Load Comment.nvim configuration
require('comment_config')

-- Load DAP configuration
require('dap_config')

-- Load Illuminate configuration
require('illuminate_config')

-- Load CMP configuration
require('cmp_config')
