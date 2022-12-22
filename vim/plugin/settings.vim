""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark
let g:codedark_conservative = 1
colorscheme codedark
" colorscheme gruvbox-baby

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
" Enable visual block selection with ctrl
nnoremap <C-LeftMouse> <4-LeftMouse>
inoremap <C-LeftMouse> <4-LeftMouse>
onoremap <C-LeftMouse> <C-C><4-LeftMouse>
" nnoremap <C-LeftDrag>  <LeftDrag>
" inoremap <C-LeftDrag>  <LeftDrag>
" onoremap <C-LeftDrag>  <C-C><LeftDrag>

" Shift-wheel scrolls left/right
nnoremap <S-ScrollWheelUp>     <ScrollWheelLeft>
nnoremap <S-2-ScrollWheelUp>   <2-ScrollWheelLeft>
nnoremap <S-3-ScrollWheelUp>   <3-ScrollWheelLeft>
nnoremap <S-4-ScrollWheelUp>   <4-ScrollWheelLeft>
nnoremap <S-ScrollWheelDown>   <ScrollWheelRight>
nnoremap <S-2-ScrollWheelDown> <2-ScrollWheelRight>
nnoremap <S-3-ScrollWheelDown> <3-ScrollWheelRight>
nnoremap <S-4-ScrollWheelDown> <4-ScrollWheelRight>

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

" Disable arrows in normal, take goods habits!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" When into a pop menu, enter is equivalent to c-y and avoid to insert new line
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Disable recording
map q <Nop>

" Fix blinking cursor in Neovim
set guicursor+=n-v-c:blinkon1

" Navigate across braces with tab instead of %
nnoremap <tab> %
vnoremap <tab> %

" shift-tab parses ()/[]/{} in insert mode
inoremap <S-Tab> <esc>%a

" Remap to search for a pattern
map s <Nop>
map S <Nop>
nnoremap s /
nnoremap S ?

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
