""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Control-c remove hightlighted search and sneak match
noremap <silent> <C-c> :noh<cr>

" Disable arrows in normal, take goods habits!
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" When into a pop menu, enter is equivalent to c-y and avoid to insert new line
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Disable macros
map q <Nop>

" Navigate across braces with tab instead of %
nnoremap <tab> %
vnoremap <tab> %

" shift-tab parses ()/[]/{} in insert mode
inoremap <S-Tab> <esc>%a

" Remap to search for a pattern
map s <Nop>
map S <Nop>
nnoremap <silent> s :call MoveToPattern() <CR>
nnoremap <silent> S :call MoveToPattern("b") <CR>

" center screen to the matched string
nnoremap n nzz
nnoremap N Nzz
nnoremap * *N

" Avoid c-w to move around panes
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Use ctrl-t for tag parsing
nmap <C-T> <C-]>
