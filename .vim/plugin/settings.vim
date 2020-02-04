"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark

colorscheme iceberg

" Set utf8 as standard encoding and en_US as the standard language
set encoding=UTF-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Always show the status line
set laststatus=2

" Display on status line:
"   - buffer number
"   - line number / max line
"   - file name
set statusline=
set statusline+=buffer\ %n\ -
set statusline+=\ line\ %l/%L\ -
set statusline+=\ %f

" Display wild menu
set wildmenu
set wildmode=longest:full,full

" Display line numbers
set number
set numberwidth=4

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

" Display max column width recommended
set colorcolumn=80
" Display current line
set cursorline

" Display matched bracket or parenthesis
set showmatch

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

" Auto comment new line if previous one was a comment
set formatoptions+=r

" A buffer becomes hidden when it is abandoned
set hidden

" always show signcolumns
set signcolumn=yes

" Better display for messages
set cmdheight=2

" Close a buffer, but not the panel
command! Bd bp | sp | bn | bd

" Histogram-based diff
if has('nvim') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" Reduce delay when pressing ESC
set timeoutlen=1 ttimeoutlen=0

" Control-c remove hightlighted search
nnoremap <silent> <C-c> :noh<cr>

" Indent wrapped lines
set breakindent

" Search down into subfolders with find command
" Provides tab completion for all file-related tasks
set path+=**

" Allow access to external clipboard
set clipboard+=unnamed
