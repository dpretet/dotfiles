" Load pathogen plugin to ease plugin load (bundle folder)
execute pathogen#infect() 
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

set background=dark
set nocompatible
set hidden
filetype plugin on

set bs=indent,eol,start

syntax on
set nowrap
set autoread
set wildmode=longest,list,full  
set wildmenu  
set showmatch
set ignorecase
set smartcase

set number
set numberwidth=4

set showcmd
set mouse=a
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
map <F2> :retab <CR> :w <CR>
" Remove space at end of line
map <F3> :%s/\s\+$// <CR>

" Replace ctrl-space for completion"
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For template
iab <for> for (i=0;i<max;i=i+1)<cr>begin<cr>end

" Regular synchronous always block
iab <always> always @ (posedge clk or negedge rstn) begin<cr><cr>    if (rstn==1'b0) begin<cr>end<cr>else begin<cr>end<cr><bs>end

" Declare a FSM, parameter,signal  and process
iab <fsm> localparam [3:0] IDLE = 0,<cr>                 STATE1 = 1;<cr><bs><bs><bs><bs><bs>reg[3:0] state;<cr><cr>always @ (posedge clk or negedge rstn)<cr>begin<cr>    if (rstn==1'b0) begin<cr> state <= ID$LE;<cr>end<cr>else begin<cr>    case (state)<cr>    default : begin<cr>end<cr>STATE1 : begin<cr>end<cr><bs>endcase<cr><bs>end<cr><bs>end

" Declare a function
iab <function> function integer func(input interger i);<cr>begin<cr>end<cr>endfunction

" Automaticaly load templates when editing new buffer
au bufNewFile *.v 0r ~/.vim/templates/template.v
au bufNewFile *.xml 0r ~/.vim/templates/template.xml
au bufNewFile *.html 0r ~/.vim/templates/template.html
au bufNewFile *.py 0r ~/.vim/templates/template.py

au BufRead,BufNewFile *.mkd,*.markdown,*.mdwn,*.mk   set filetype=mkd


