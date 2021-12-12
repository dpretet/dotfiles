""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark
colorscheme codedark

" Use Unix as the standard file type
set ffs=unix,dos,mac
set encoding=utf-8
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
" Display current line
set cursorline

" Display matched bracket or parenthesis
set showmatch

" Don't wrap long lines
set nowrap

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

" Reduce delay when pressing ESC
set timeoutlen=1 ttimeoutlen=1

" Control-c remove hightlighted search and sneak match
noremap <silent> <C-c> :noh<cr>

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
"
" Enter key is equivalent to c-y thus doesn't add a new line when completing
" deactivated because leading nvim-compe to exit menu if hitting return
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Disable recording
map q <Nop>

" Fix blinking cursor in Neovim
set guicursor+=n-v-c:blinkon1

" Navigate across braces with tab instead of %
nnoremap <tab> %
vnoremap <tab> %

" shift-tab parses ()/[]/{} in insert mode
inoremap <S-Tab> <esc>%a

" change the direction of new splits
set splitbelow
set splitright

" center screen to the matched string
nnoremap n nzz
nnoremap N Nzz
