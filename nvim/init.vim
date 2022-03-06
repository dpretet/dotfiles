"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management, by Vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'tomasiser/vim-code-dark'
Plug 'ryanoasis/vim-devicons'
" Languages
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'dpretet/vim-markdown-tool'
Plug 'dpretet/vim-veritoolbox'
Plug 'kylelaker/riscv.vim'
" Misc.
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dpretet/vim-leader-mapper'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'dpretet/vim-commenter'
Plug 'skywind3000/asyncrun.vim'
Plug 'christoomey/vim-tmux-navigator'


call plug#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sub scripts handling the settings for plugins and core
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $HOME/.config/nvim/plugin/settings.vim
source $HOME/.config/nvim/plugin/plugins.vim
source $HOME/.config/nvim/plugin/functions.vim
source $HOME/.config/nvim/ftplugin/files.vim

autocmd BufWritePost settings.vim source %
autocmd BufWritePost plugins.vim source %
autocmd BufWritePost functions.vim source %
autocmd BufWritePost files.vim source %
