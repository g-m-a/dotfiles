" include subfolders to path
" set path+=*

" setup some stuff for windows
if has('win32')
    set shell=powershell.exe
    set shellquote= shellpipe=\| shellxquote=
    set shellcmdflag=\ -NoLogo\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif | "Set Default Shell Application to PowerShell

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*


" load plugins
source ~/.config/nvim/plugins.vim

" generic vim stuff
let g:gruvbox_contrast_dark = 'hard'
autocmd vimenter * ++nested colorscheme gruvbox
set autoread
set grepprg=rg\ --vimgrep\ --smart-case\ --follow\ --hidden
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set relativenumber
set number
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set smartcase
set splitbelow
set splitright
set scrolloff=3
set cursorline
filetype indent on
filetype plugin indent on
syntax on

" source ~/.config/nvim/keys.vim
