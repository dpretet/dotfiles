"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management, by Vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'gosukiwi/vim-atom-dark'
Plug 'ryanoasis/vim-devicons'
" Languages
Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'dpretet/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'kristijanhusak/completion-tags'

Plug 'dpretet/vim-markdown-tool'
Plug 'dpretet/vim-veritoolbox'
" Misc.
Plug 'Chiel92/vim-autoformat'
Plug 'justinmk/vim-sneak'
Plug 'dpretet/vim-leader-mapper'
Plug 'junegunn/fzf.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'scrooloose/nerdtree'
Plug 'AndrewRadev/switch.vim'
Plug 'dpretet/vim-commenter'
Plug 'skywind3000/asyncrun.vim'

call plug#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sub scripts handling the settings for plugins and core
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $HOME/.config/nvim/plugin/settings.vim
source $HOME/.config/nvim/plugin/plugins.vim
source $HOME/.config/nvim/plugin/functions.vim
source $HOME/.config/nvim/plugin/lsp.vim
source $HOME/.config/nvim/ftplugin/files.vim
