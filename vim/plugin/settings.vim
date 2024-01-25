""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark

let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" colorscheme darktech

set termguicolors

" Use Unix as the standard file type
set ffs=unix,dos,mac
set encoding=UTF-8
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

" Display max column width recommended
set colorcolumn=100
" Display current line & column
set cursorline
set cursorcolumn

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

" Always display sign column
set signcolumn=yes

" A buffer becomes hidden when it is abandoned
set hidden

" Better display for messages
set cmdheight=2

" Reduce delay when pressing ESC
set timeoutlen=1 ttimeoutlen=1

" Control-c remove hightlighted search and sneak match
noremap <silent> <C-c> :noh<cr>

" Search down into subfolders with find command
" Provides tab completion for all file-related tasks
set path+=**

" Live substitution with s command
if has("nvim")
    set inccommand=split
endif

" Completion setup for mu-complete
set completeopt+=menuone
set completeopt+=noinsert
set shortmess+=c


" Disable arrows in normal, take goods habits!
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Use <Tab> and <S-Tab> to navigate through popup menu (off because of mu-complete)
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" When into a pop menu, enter is equivalent to c-y and avoid to insert new line
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Disable recording
map q <Nop>

" Fix blinking cursor in Neovim
set guicursor+=n-v-c:blinkon1

" Navigate across braces with tab instead of %
nnoremap <tab> %
vnoremap <tab> %

" shift-tab parses ()/[]/{} in insert mode (off because of mu-complete)
" inoremap <S-Tab> <esc>%a

" Remap to search for a pattern
map s <Nop>
map S <Nop>
" nnoremap s /
" nnoremap S ?
nnoremap <silent> s :call MoveToPattern() <CR>
nnoremap <silent> S :call MoveToPattern("b") <CR>

" change the direction of new splits
set splitbelow
set splitright

" center screen to the matched string
nnoremap n nzz
nnoremap N Nzz
nnoremap * *N

hi VertSplit ctermbg=0 ctermfg=0
hi StatusLine ctermbg=0 ctermfg=15

" Maximum textwidth for line folding and wrapping
set textwidth=100

" Ignore whitespace on diff
set diffopt+=iwhite
set diffexpr=""

" Include underscore as a keyword
set iskeyword+=_

set completeopt-=preview

" Avoid c-w to move around panes
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Netrw
let g:netrw_menu = 0
let g:netrw_banner = 0
let g:netrw_winsize = 30
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_fastbrowse = 0
