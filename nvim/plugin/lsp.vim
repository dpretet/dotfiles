"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tree-Sitter setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << END
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,  -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}
END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load the language servers
lua require'lspconfig'.ccls.setup{}
lua require'lspconfig'.ccls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.svls.setup{}
lua require'lspconfig'.svls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.bashls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.pyls.setup{}
lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" LSP completion is by default used for omnifunc
autocmd FileType * set omnifunc=v:lua.vim.lsp.omnifunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" completion.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
" set shortmess+=c
" Define completion strategy when popping up the menu
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
