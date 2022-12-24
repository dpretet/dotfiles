---------------------------------------------------------------------------------
-- Plugins Management
---------------------------------------------------------------------------------

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)

  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-buffer',
                 'hrsh7th/cmp-path',
                 'hrsh7th/cmp-vsnip',
                 'hrsh7th/cmp-cmdline',
                 'hrsh7th/vim-vsnip' }
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use 'dense-analysis/ale'
  use 'dpretet/vim-veritoolbox'
  use 'dpretet/vim-leader-mapper'
  use 'kylelaker/riscv.vim'
  use 'powerman/vim-plugin-AnsiEsc'
  use 'tpope/vim-commentary'
  use 'skywind3000/asyncrun.vim'
  use 'christoomey/vim-tmux-navigator'
  use 'folke/tokyonight.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'echasnovski/mini.nvim'

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  -- local has_plugins, plugins = pcall(require, 'custom.plugins')
  -- if has_plugins then
  --   -- plugins(use)
  -- end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end


---------------------------------------------------------------------------------
-- Automatically source and re-compile packer whenever you save this init.lua
---------------------------------------------------------------------------------
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


---------------------------------------------------------------------------------
-- [[ Setting options ]]
-- See `:help vim.o`
-- See `:help vim.opt`
---------------------------------------------------------------------------------

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight]]
-- vim.cmd [[colorscheme tokyonight-night]]
-- vim.cmd [[colorscheme tokyonight-storm]]
-- vim.cmd [[colorscheme tokyonight-moon]]

-- Make cursor blinking in all mode
vim.o.guicursor = "n-v-c-i:blinkon1"
-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

-- Different line/column/cursor setup
vim.opt.colorcolumn = "100"
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- Display matched bracket or parenthesis
vim.o.showmatch = true

-- Don't wrap long lines
vim.wo.wrap = false

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Set highlight on search
vim.o.hlsearch = true
-- Live substitution with s command
vim.o.inccommand = "split"

-- Hide by default the empty buffers
vim.o.hidden = true

-- Disable backup and swap
vim.o.backup = false
vim.o.swapfile = false

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Reduce delay when pressing ESC
vim.o.timeoutlen = 1
vim.o.ttimeoutlen = 1

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- change the direction of new splits
vim.o.splitright = true
vim.o.splitbelow = true


---------------------------------------------------------------------------------
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
---------------------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Navigate across braces with tab instead of %
vim.keymap.set({ 'n', 'v' }, '<Tab>', '%')
-- shift-tab parses ()/[]/{} in insert mode
vim.keymap.set({ 'i' }, '<S-Tab>', '<esc>%a')

-- center screen to the matched string
vim.keymap.set({ 'n' }, 'n', 'nzz')
vim.keymap.set({ 'n' }, 'N', 'Nzz')
vim.keymap.set({ 'n' }, '*', '*N')

-- Disable recording
vim.keymap.set({ 'n' }, 'q', '<Nop>')

-- Control-c remove hightlighted search
vim.keymap.set('n', '<C-c>' ,':noh<cr>')


---------------------------------------------------------------------------------
-- Functions, lang setup and templates
---------------------------------------------------------------------------------

vim.cmd('source ~/.config/nvim/files.vim')
vim.cmd('source ~/.config/nvim/functions.vim')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


---------------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------------

-- [[ Configure TokyoNight Theme ]]
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
})


-- [[ Configure ALE ]]
-- :help ALE
vim.cmd('source ~/.config/nvim/ale.vim')


-- [[ Configure mini.nvim library ]]
-- Animate cursor movment and scrolling
-- require('mini.animate').setup()
-- Auto close parenthesis and brackets
require('mini.pairs').setup()
-- Starter menu-
require('mini.starter').setup()
-- Customized status line
require('mini.statusline').setup()
-- Highlight word under cursor
require('mini.cursorword').setup()


--  [[ LeaderMapper menu ]]
vim.g["leaderMenu"] = {
  f = {':Telescope find_files', 'Fuzzy find files'},
  l = {':ls',                   'List opened buffers'},
  d = {':Bclose',               'Close buffer (but keeps the panel)'},
  o = {':normal gF',            'Open file under cursor'},
  v = {':vsplit',               'Split buffer vertically'},
  h = {':split',                'Split buffer horizontally'},
  H = {':hide',                 'Hide panel'},
  c = {":Commentary",           'Toggle comment on current line'},
  C = {":'<,'>Commentary",      'Toggle comment on visual selection'},
  s = {':call FloatTerm()',     'Open a floating terminal'},
  x = {':%!xxd',                'Display a buffer in hexadecimal'},
  t = {':Telescope',            'Call Telescope'},
  T = {':call BuildCtags()',    'Create tags'}
}

vim.keymap.set({ 'n', 'v' }, '<leader>', ':LeaderMapper<cr>')


-- [[ Configure indent_blankline ]]
-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
  show_end_of_line = true,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- [[ Configure Nvim-cmp ]]
local cmp = require 'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
