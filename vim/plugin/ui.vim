""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark
set t_Co=256
set termguicolors

" Gruvbox theme setup
let g:gruvbox_italic=1
" Fix italic comment background (https://github.com/sainnhe/gruvbox-material/issues/5)
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
colorscheme gruvbox

" Display max column width recommended
set colorcolumn=100
" Display current line & column
set cursorline
set cursorcolumn

" Bottom screen height for command and status info
set cmdheight=2
set laststatus=2

" Display line numbers
set number
set numberwidth=4

" Display line number
set number
set numberwidth=4

" Keep the autocomplete suggestion menu small
set pumheight=20

" Wildmenu setup:
set wildmenu
" longest:full" : Like "longest", but also start 'wildmenu' if it is enabled.
" full"         : Complete the next full match
set wildmode=longest:full,full
" Not for Gvim while being still v7 based
if !has("gui_running")
    " wildmenu displayed in a popup
    set wildoptions=pum
    " Fuzzy search over the popup
    set wildoptions+=fuzzy
endif

" Always display sign column
set signcolumn=yes

" Split and status line color
hi VertSplit ctermbg=0 ctermfg=0
hi StatusLine ctermbg=0 ctermfg=15

" Netrw
let g:netrw_menu = 0
let g:netrw_banner = 0
let g:netrw_winsize = 30
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_fastbrowse = 0
