"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key setup, handled with vim-leader-mapper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Shortcut created and handled by Vim-leader-mapper
let g:leaderMenu = {'name':  "",
             \'f': [":Files",                       "FZF file search"],
             \'b': [":Buffers",                     "FZF buffer search"],
             \'s': [":BLines",                      "FZF text search into current buffer"],
             \'S': [":Lines",                       "FZF text search across loaded buffers"],
             \'g': [":BCommits",                    "FZF git commits of the current buffer"],
             \'G': [":Commits",                     "FZF git commits of the repository"],
             \'v': [':vsplit',                      'Split buffer vertically'],
             \'h': [':split',                       'Split buffer horizontally'],
             \'d': [':bd',                          'Close buffer'],
             \'D': [':Bd',                          'Close buffer, but not the panel'],
             \'r': [':so $MYVIMRC',                 'Reload vimrc without restarting Vim'],
             \'q': [':wq',                          'Write buffer and close'],
             \'w': [':w',                           'Write buffer'],
             \'W': [':w !sudo tee % > /dev/null',   'Write buffer with sudo rights'],
             \'l': [':ls',                          'List opened buffers'],
             \'p': [':call Prettify()',             'Prettify the buffer'],
             \'z': [':Goyo',                        'Enter in Zen mode'],
             \'t': [':Tags',                        'FZF tag search'],
             \'o': [':normal gf',                   'Open file under cursor'],
             \'n': [':NERDTreeToggle',              'Open/Close NerdTree'],
             \'c': [':Commenter',                   'Comment/Uncomment visual selection'],
             \}

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable fzf
set rtp+=~/.fzf

" ctrl-h or ctrl-v can be pressed to open a file found
" into a new panel
let g:fzf_action = {
            \ 'ctrl-h': 'split',
            \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Using floating windows of Neovim to start fzf
if has('nvim')

  let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.7)
    let height = float2nr(&lines * 0.5)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

else
    " Open FZF in the middle of the screen.
    " Can be down / up / left / right
    let g:fzf_layout = { 'down': '~50%' }
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoFormat setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_auto_extension_ext = 'txt'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-T> <C-]>
set tags=tags,./tags,./../tags,./*/tags
" let g:gutentags_trace = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use NERDTree because netrw suffers several problems:
" - open empty buffer, and may prevent to close vim
" - don't auto close explore once a file is selected
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_sign_error = '🔻'
let g:ale_sign_warning = '🔸'
