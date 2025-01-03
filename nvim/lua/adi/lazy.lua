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
    },
    lazy = false
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
       -- always load the LazyVim library
      "LazyVim",
      -- Only load the lazyvim library when the `LazyVim` global is found
      { path = "LazyVim", words = { "LazyVim" } }, -- See the configuration section for more details
      },
    },
   lazy = true
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
   lazy = false
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
    lazy = true
  },
  {'nvim-treesitter/nvim-treesitter-context', lazy = true},
  {'lewis6991/gitsigns.nvim', lazy = true},
  {'ellisonleao/gruvbox.nvim', lazy = true},
  {'nvim-lualine/lualine.nvim', lazy = true},
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    lazy = true
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
    lazy = true
  },
  { "mg979/vim-visual-multi", branch= "master" },
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
    lazy = true
  },
  {
    "RRethy/vim-illuminate",
    lazy = true
  }
}, {})
