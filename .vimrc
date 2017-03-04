execute pathogen#infect()

filetype plugin on
syntax on
colorscheme srcery
let g:airline_theme='luna'
let g:airline_powerline_fonts=1
let g:vim_markdown_folding_disabled = 1

set nocompatible
set hidden

set bs=indent,eol,start
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
set softtabstop=4
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" file formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace tab by space in a text
map <F2> :retab <CR> :w <CR> :noh <CR>
" Remove space at end of line
map <F3> :%s/\s\+$// <CR> :noh <CR>
" Convert 2 spaces indent to 4 spaces
map <F4> :set ts=2 <CR> :set noexpandtab <CR> :retab! <CR> :set expandtab <CR> :set ts=4 <CR> :retab <CR> :noh <CR>
" Close a buffer without closing its pane
command Bd bp\|bd \#
"Autoclose the preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete

" Replace ctrl-space for completion"
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Verilog snippet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab <for> for (i=0;i<max;i=i+1)<cr>begin<cr>end
iab <always> always @ (posedge clk or negedge rstn) begin<cr><cr>        if (arstn == 1'b0) begin<cr>end<cr>else if (srst == 1'b1) begin<cr>end<cr>else begin<cr>end<cr><bs>end
iab <fsm> localparam [3:0] IDLE = 0,<cr>                                 STATE1 = 1;<cr><bs><bs><bs><bs><bs>reg[3:0] state;<cr><cr>always @ (posedge clk or negedge rstn)<cr>begin<cr>      if (rstn==1'b0) begin<cr> state <= ID$LE;<cr>end<cr>else begin<cr>      case (state)<cr>        default : begin<cr>end<cr>STATE1 : begin<cr>end<cr><bs>endcase<cr><bs>end<cr><bs>end
iab <function> function integer func(input interger i);<cr>begin<cr>end<cr>endfunction
iab <task> task myTask;<cr>endtask<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automaticaly load templates when editing new buffer
" regarding filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au bufNewFile *.v 0r ~/.vim/templates/template.v
au bufNewFile *.xml 0r ~/.vim/templates/template.xml
au bufNewFile *.html 0r ~/.vim/templates/template.html
au BufRead,BufNewFile *.json set filetype=javascript 
au bufNewFile *.py 0r ~/.vim/templates/template.py
au bufNewFile *.tcl 0r ~/.vim/templates/template.tcl
au BufNewFile,BufRead *.sv,*.svh,*.vh,*.v so ~/.vim/bundle/systemverilog.vim/syntax/systemverilog.vim
au BufRead,BufNewFile *.mkd,*.markdown,*.mdwn,*.mk,*.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType make setlocal noexpandtab

