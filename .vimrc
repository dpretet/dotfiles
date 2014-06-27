execute pathogen#infect() 

if exists('$TMUX')
  set term=screen-256color
endif

colors grb256
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1

set nocompatible
set hidden

set bs=indent,eol,start

syntax on
set textwidth=0 
set wrapmargin=0
set nowrap
set autoread
set wildmode=longest:full,full  
set wildmenu  
set showmatch
set ignorecase
set smartcase

set number
set numberwidth=4

set showcmd
set mouse=a
set mouse=nicr
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround
set smarttab
set showtabline=2

set autoindent
set copyindent

set laststatus=2
set cmdheight=2

set hlsearch
set incsearch

set nobackup
set noswapfile

" Replace tab by space in a text
map <F2> :retab <CR> :w <CR> :noh <CR>
" Remove space at end of line
map <F3> :%s/\s\+$// <CR> :noh <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete
" Replace ctrl-space for completion"
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
"Autoclose the preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For template
iab <for> for (i=0;i<max;i=i+1)<cr>begin<cr>end

" Regular synchronous always block
iab <always> always @ (posedge clk or negedge rstn) begin<cr><cr>    if (arstn == 1'b0) begin<cr>end<cr>else if (srst == 1'b1) begin<cr>end<cr>else begin<cr>end<cr><bs>end

" Declare a FSM, parameter,signal  and process
iab <fsm> localparam [3:0] IDLE = 0,<cr>                 STATE1 = 1;<cr><bs><bs><bs><bs><bs>reg[3:0] state;<cr><cr>always @ (posedge clk or negedge rstn)<cr>begin<cr>    if (rstn==1'b0) begin<cr> state <= ID$LE;<cr>end<cr>else begin<cr>    case (state)<cr>    default : begin<cr>end<cr>STATE1 : begin<cr>end<cr><bs>endcase<cr><bs>end<cr><bs>end

" Declare a function
iab <function> function integer func(input interger i);<cr>begin<cr>end<cr>endfunction

" Automaticaly load templates when editing new buffer
au bufNewFile *.v 0r ~/.vim/templates/template.v
au bufNewFile *.xml 0r ~/.vim/templates/template.xml
au bufNewFile *.html 0r ~/.vim/templates/template.html
au bufNewFile *.py 0r ~/.vim/templates/template.py
au bufNewFile *.tcl 0r ~/.vim/templates/template.tcl
au BufRead,BufNewFile *.sv set filetype=verilog
au BufRead,BufNewFile *.mkd,*.markdown,*.mdwn,*.mk   set filetype=mkd

"au BufEnter *.v compiler "verilator --lint-only"
"au BufEnter *.sv compiler "verilator --lint-only"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

