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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'dpretet/vim-markdown-tool'
Plug 'dpretet/vim-veritoolbox'
Plug 'kylelaker/riscv.vim'
" Misc.
Plug 'dpretet/vim-leader-mapper'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'Konfekt/vim-CtrlXA'
Plug 'dpretet/vim-commenter'
Plug 'skywind3000/asyncrun.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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

autocmd BufWritePost settings.vim source %
autocmd BufWritePost plugins.vim source %
autocmd BufWritePost functions.vim source %
autocmd BufWritePost lsp.vim source %
autocmd BufWritePost files.vim source %
