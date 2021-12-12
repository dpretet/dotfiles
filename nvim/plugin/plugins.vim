"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key setup, handled with vim-leader-mapper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Define FZF leader key menu
let g:TelescopeMenu = {'name': "Telescope Menu",
             \'f': [":Telescope find_files",        "File search"],
             \'b': [":Telescope buffers",           "Lists open buffers in current neovim instance"],
             \'s': [":Telescope live_grep",         "Search for a string in your current directory"],
             \'S': [":Telescope search_history",    "Lists searches that were executed recently"],
             \'t': [':Telescope tags',              'Tag search'],
             \'h': [':Telescope command_history',   'Command history search'],
             \}

" Define Main leader key menu
let g:leaderMenu = {'name': "Main",
             \'F': [':Telescope',                   'Open Telescope'],
             \'f': [TelescopeMenu,                  "Open Telescope menu"],
             \'m': [MdMenu,                         'Open Markdown menu'],
             \'v': [':vsplit',                      'Split buffer vertically'],
             \'h': [':split',                       'Split buffer horizontally'],
             \'H': [':hide',                        'Hide panel'],
             \'d': [':Bclose',                      'Close buffer'],
             \'l': [':ls',                          'List opened buffers'],
             \'t': [':call BuildCtags()',           'Create tags'],
             \'o': [':normal gF',                   'Open file under cursor'],
             \'e': [':NERDTreeToggle',              'Open/Close NerdTree'],
             \'c': [':Commenter',                   'Toggle comment of current line or visual selection'],
             \':': [':call FloatTerm()',            'Open a floating terminal'],
             \'b': [':make',                        'Run make program (set makeprg="..." to setup)'],
             \'x': [':%!xxd',                       'Display a buffer in hexadecimal'],
             \}

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-T> <C-]>
set tags=tags,./tags,./../tags,./*/tags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlXA
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup VimAfter
    autocmd!
    autocmd VimEnter let g:CtrlXA_Toggles = [
    \   ['input', 'output'],
    \   ['reg', 'wire', 'logic'],
    \   ['===', '!=='],
    \   ['task', 'function'],
    \   ['posedge', 'negedge'],
    \   ['New', 'Change', 'Fix', 'Feature', 'Refactor', 'Chore', 'Doc'],
    \ ] + g:CtrlXA_Toggles
augroup END
