"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tree-Sitter setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << END
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "bash", "verilog", "python", "vim"},
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
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.svls.setup{}
lua require'lspconfig'.bashls.setup{}
" lua require'lspconfig'.pyls.setup{}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comp plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set completeopt=menuone,noselect

lua <<EOF

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({

    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },

  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

EOF
