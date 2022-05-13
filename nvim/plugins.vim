call plug#begin('~/.vim/plugged')
" gruvbox
Plug 'morhetz/gruvbox'
 
" Neovim Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" HARPOON!!
Plug 'mhinz/vim-rfc'
Plug 'ThePrimeagen/harpoon'

" prettier
Plug 'sbdchd/neoformat'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" copilot
Plug 'github/copilot.vim'

" statusline stuff
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/tagbar'
Plug 'tpope/vim-fugitive'

Plug 'simrat39/symbols-outline.nvim'

" coc.nvim stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

call plug#end()
