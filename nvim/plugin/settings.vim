""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark
colorscheme atom-dark-256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=UTF-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Always show the status line
set laststatus=2

" Display cursor position
set ruler

" Display wild menu
set wildmenu
set wildmode=longest:full,full

" Display line numbers
set number
set numberwidth=4

" Enable mouse in all modes
" set mouse=a

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

" Display max column width recommended
set colorcolumn=80
" Display current line
set cursorline

" Display matched bracket or parenthesis
set showmatch

" Don't wrap long lines
set nowrap

" Display absolute and relative line number
set nu rnu

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

" Always display sign column
set signcolumn=yes

" Auto comment new line if previous one was a comment
" set formatoptions+=r

" A buffer becomes hidden when it is abandoned
set hidden

" Better display for messages
set cmdheight=2

" Close a buffer, but not the panel
command! Bd bp | sp | bn | bd

" Reduce delay when pressing ESC
set timeoutlen=1 ttimeoutlen=0

" Control-c remove hightlighted search and sneak match
noremap <silent> <C-c> :noh \| call sneak#cancel()<cr>

" Search down into subfolders with find command
" Provides tab completion for all file-related tasks
set path+=**

" Live substitution with s command
set inccommand=split

" Disable arrows in normal, take goods habits!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Enter key is equivalent to c-y thus doesn't add a new line when completing
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
