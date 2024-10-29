-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Indentation settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.sts = 2

-- Other settings
vim.o.colorcolumn = "80"
vim.o.scrolloff = 3
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.splitright = true
vim.o.smarttab = true
vim.o.grepprg = "rg --vimgrep --smart-case --follow --hidden --no-ignore-vcs --no-ignore --no-ignore-global --no-ignore-parent"
vim.o.autoread = true
