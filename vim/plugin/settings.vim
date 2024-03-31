""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Unix as the standard file type
set ffs=unix,dos,mac
set encoding=UTF-8
" Always show the status line
set laststatus=2

set backspace=indent,eol,start

" Display cursor position
set ruler

" Enable mouse in all modes
set mouse=a

" Use spaces instead of tabs
set expandtab
" Define 1 tab = 4 spaces by default
set tabstop=4
set shiftwidth=4
set shiftround

" Auto indent lines
set autoindent
set smartindent
set nocindent

" Display matched bracket or parenthesis
set showmatch

" Don't wrap long lines
set nowrap

" Don't auto-wrap text using textwidth
set formatoptions-=t
" Auto-comment new line when was into a comment line
set formatoptions+=r
" Indent wrapped lines
set breakindent

" Display pattern found while typing
set incsearch
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch

" Disable backup and swap
set nobackup
set noswapfile

" A buffer becomes hidden when it is abandoned
set hidden

" Reduce delay when pressing ESC
set timeoutlen=1 ttimeoutlen=1

" change the direction of new splits
set splitbelow
set splitright

" Maximum textwidth for line folding and wrapping
set textwidth=100

" Ignore whitespace on diff
set diffopt+=iwhite
set diffexpr=""
" Better diff algorithm
set diffopt+=internal,algorithm:patience

