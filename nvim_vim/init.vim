"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management, by Vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set nocompatible
filetype off

" Install vim-plug if not found
if has("nvim")
    if empty(glob('${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim'))
        silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
endif

if has("nvim")
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Theme
Plug 'dpretet/dark-tech'
" Languages
Plug 'dense-analysis/ale'
if has("nvim")
    Plug 'dpretet/vim-veritoolbox'
    Plug 'dpretet/vim-markdown-tool'
endif
Plug 'lifepillar/vim-mucomplete'
Plug 'kylelaker/riscv.vim'
" Misc.
Plug 'ctrlpvim/ctrlp.vim'
if has("nvim")
    Plug 'dpretet/vim-leader-mapper'
endif
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'dpretet/vim-commenter'
Plug 'skywind3000/asyncrun.vim'
Plug 'christoomey/vim-tmux-navigator'


call plug#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sub scripts handling the settings for plugins and core
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
    source $HOME/.config/nvim/plugin/settings.vim
    source $HOME/.config/nvim/plugin/plugins.vim
    source $HOME/.config/nvim/plugin/functions.vim
    source $HOME/.config/nvim/ftplugin/files.vim
else
    source $HOME/.vim/plugin/settings.vim
    source $HOME/.vim/plugin/functions.vim
    source $HOME/.vim/plugin/plugins.vim
    source $HOME/.vim/ftplugin/files.vim
endif

" Auto-reload the settings if changed
if has('nvim')
    autocmd! bufwritepost init.vim source %
else
    autocmd! bufwritepost .vimrc source %
endif
autocmd! bufwritepost settings.vim source %
autocmd! bufwritepost functions.vim source %
autocmd! bufwritepost plugins.vim source %
autocmd! bufwritepost files.vim source %
