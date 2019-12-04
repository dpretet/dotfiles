"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key setup, handled with vim-leader-guide
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use space bar as leader key
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" Make the menu to pop up when pressing space
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

" Shortcut created and handled by Vim-leader-guide
let g:lmap = {'name':  "",
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

" Scala setup
let g:formatdef_scalafmt = '"scalafmt --stdin 2>/dev/null"'
let g:formatters_scala = ['scalafmt']
let g:scala_scaladoc_indent = 1

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
" CTags & Autotag setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-T> <C-]>
set tags=./tags,./../tags,./*/tags
let g:autotagTagsFile="./tags"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc setup (Conquer of completion)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" You will have bad experience for diagnostic messages when it's default 4000.
" Reduce also linting slowness
set updatetime=100

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow Paranthesis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au VimEnter * RainbowParentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
