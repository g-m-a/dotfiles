local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ignore_install = { "help" }
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  'nvim-treesitter/nvim-treesitter-context',
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',
  "ellisonleao/gruvbox.nvim",
  'nvim-lualine/lualine.nvim',
  'numToStr/Comment.nvim',
  'tpope/vim-sleuth',
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'ThePrimeagen/harpoon',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 200,
        keymap = {
          accept = "<S-Right>",
          next = "<S-Down>",
          prev = "<S-Up>",
          dismiss = "<S-Esc>",
        }
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<S-Left>"
        },
        layout = {
          position = "right",
          ratio = 0.2
        },
      },
    },
  },
  { "mg979/vim-visual-multi", branch= "master"},
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
      {
        "microsoft/vscode-js-debug",
        branch = "main",
        opt = true,
        build = "npm ci && npm run compile vsDebugServerBundle && rm -rf out/dist && mv dist out && git reset --hard"
      }
    },
  },
  {
    "RRethy/vim-illuminate"
  }
}, {})
