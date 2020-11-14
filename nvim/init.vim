"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management, by Vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'gosukiwi/vim-atom-dark'
Plug 'ryanoasis/vim-devicons'
" Languages
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vhda/verilog_systemverilog.vim'
Plug 'dpretet/vim-markdown-tool', { 'tag': 'main' }
Plug 'Chiel92/vim-autoformat'
Plug 'dpretet/vim-veritoolbox'
" Misc.
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

source ~/.config/nvim/plugin/settings.vim
source ~/.config/nvim/plugin/functions.vim
source ~/.config/nvim/plugin/plugins.vim
source ~/.config/nvim/ftplugin/files.vim
