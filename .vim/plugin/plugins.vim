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
             \'W': [':w !sudo tee % > /dev/null',   'Write buffer with Sudo rights'],
             \'l': [':ls',                          'List opened buffers'],
             \'p': [':call Prettify()',             'Prettify the buffer'],
             \'z': [':Goyo',                        'Enter in Zen mode'],
             \'t': [':Tags',                        'FZF tag search'],
             \'o': [':normal gf',                   'Open file under cursor'],
             \'n': [':NERDTreeToggle',              'Open/Close NerdTree'],
             \'i': [':call PrintWorkflowInfo()',    'Print information about usual commands'],
             \'c': [':call CommentToggle()',        'Comment/Uncomment visual selection'],
             \}

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <leader> :call leaderMapper#start() "<Space>"<CR>
vnoremap <silent> <leader> :call leaderMapper#start() "<Space>"<CR>


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
" Autopep8 setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable show diff version of autopep8
let g:autopep8_disable_show_diff=1
" Automatically format the file on save
let g:autopep8_on_save = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoFormat setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" Python setup
let g:formatter_yapf_style = 'pep8'
let g:formatters_python = ['autopep8']


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" asyncomplete setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
" Force refresh completion
imap <c-space> <Plug>(asyncomplete_force_refresh)
" Enable preview window
set completeopt+=preview
" Auto close preview once completion done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

