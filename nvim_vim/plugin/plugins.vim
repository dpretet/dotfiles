"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key setup, handled with vim-leader-mapper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

if has("nvim")

    " Define the sub-menu dedicated to Markdown tool
    let MdMenu = {'name': "Markdown Menu",
                \'tk':  [":MdAddTask",          "Add a new task"],
                \'stk': [":MdAddSubTask",       "Add a new sub task"],
                \'tt':  [":MdChangeToTask",     "Change list item to task"],
                \'tb':  [":MdAddTable",         "Add a table"],
                \'ac':  [":MdAddColumn",        "Add a column"],
                \'ar':  [":MdAddRow",           "Add a row"],
                \'swc': [":MdSwapColumn",       "Swap two columns"],
                \'swr': [":MdSwapRow",          "Swap two rows"],
                \'p':   [":MdPrettify",         "Prettify a table"],
                \'i':   [":MdAddImage",         "Add image"],
                \'l':   [":MdAddLink",          "Add link"],
                \'c':   [":MdAddCode",          "Add code block"],
                \'sn':  [":MdStatusNew",        "Assign to task 'New' status"],
                \'so':  [":MdStatusOngoing",    "Assign to task 'Ongoing' status"],
                \'sc':  [":MdStatusCancel",     "Assign to task 'Cancel' status"],
                \'sd':  [":MdStatusDone",       "Assign to task 'Done' status"],
                \}

    " Define Main leader key menu
    let g:leaderMenu = {'name': "Main",
                \'f': [":CtrlPMixed",                  "Fuzzy find with CtrlP"],
                \'l': [":ls",                          'List opened buffers'],
                \'d': [":Bclose",                      'Close buffer (but keeps the panel)'],
                \'o': [":normal gF",                   'Open file under cursor'],
                \'v': [":vsplit",                      'Split buffer vertically'],
                \'h': [":split",                       'Split buffer horizontally'],
                \'H': [":hide",                        'Hide panel'],
                \'c': [":Commenter",                   'Toggle comment of current line'],
                \'C': [":'<,'>Commenter",              'Toggle comment of visual selection'],
                \':': [":call FloatTerm()",            'Open a floating terminal'],
                \'x': [":%!xxd",                       'Display a buffer in hexadecimal'],
                \'t': [":call BuildCtags()",           'Create tags'],
                \'m': [MdMenu,                         'Open Markdown menu'],
                \}

    nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
    vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

else 

    nnoremap <Leader>f :CtrlPMixed <CR>
    nnoremap <Leader>l :ls <CR>
    nnoremap <Leader>d :Bclose <CR>
    nnoremap <Leader>o :normal gF <CR>
    nnoremap <Leader>v :vsplit <CR>
    nnoremap <Leader>h :split <CR>
    nnoremap <Leader>H :hide <CR>
    nnoremap <Leader>t :call BuildCtags() <CR>
    nnoremap <leader>c :call ToggleComment() <CR>
    nnoremap <Leader>: :terminal <CR>
    nnoremap <Leader>x :%!xxd <CR>

endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-T> <C-]>
set tags=tags,./tags,./../tags,./*/tags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '✺'

let g:ale_linters = {
\   'systemverilog': ['verilator', 'iverilog'],
\   'c': ['clang'],
\   'c++': ['clang'],
\   'python': ['pylint'],
\}

" Specify rustc option for linting (avoid to use nightly build)
let g:ale_verilog_iverilog_options = "-g2012 -I./ -I../ -I./rtl/ -I../rtl -Isrc/ -I../src -DXLEN=32"
let g:ale_verilog_verilator_options = "+1800-2017ext+sv +1800-2005ext+v  -I./ -I../ -I./rtl/ -I../rtl -Isrc/ -I../src -DXLEN=32 -Wno-STMTDLY -Wno-UNUSED -Wno-UNDRIVEN"
let g:ale_c_clangformat_options = "-I /opt/homebrew/Cellar/verilator/5.002/share/verilator/include"
