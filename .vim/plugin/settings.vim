"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key setup, handled with vim-leader-guide
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use space bar as leader key
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" Shorten plugin display time when pressing space
set timeoutlen=1

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
" General setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Color scheme
set background=dark
colorscheme space-vim-dark

if $TERM_PROGRAM =~ 'Terminal'
    hi Normal     ctermbg=NONE guibg=NONE
    hi LineNr     ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=UTF-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Always show the status line
set laststatus=2

" display on status line:
"   - buffer number,
"   - line number / max line
"   - file name
set statusline=
set statusline+=buffer\ %n\ -
set statusline+=\ line\ %l/%L\ -
set statusline+=\ %f

" Display Wild menu
set wildmenu""
set wildmode=longest:full,full

" Display line numbers
set number
set numberwidth=4

" Enable mouse in all modes
set mouse=a

" Use spaces instead of tabs
set expandtab
" Deine 1 tab = 4 spaces
set tabstop=4
set shiftwidth=4
set shiftround
" Auto indent lines
set autoindent
set smartindent

" Display max column width recommanded
set colorcolumn=100
" Display current line
set cursorline

" Display matched bracket or parenthesis
set showmatch

" Display pattern found while typing
set incsearch
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch

" Disable backup and swap
set nobackup
set noswapfile

" Auto comment new line if previous one was a comment
set formatoptions+=r

" A buffer becomes hidden when it is abandoned
set hidden

" always show signcolumns
set signcolumn=yes

" Better display for messages
set cmdheight=2

" shift-enter insert a new line
" but do not enter in insert mode
nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k

" Close a buffer, but not the panel
command Bd bp | sp | bn | bd

" Strip whitespaces and tabs on buffer write
autocmd BufWritePre <buffer> :call StripWsTabs()
