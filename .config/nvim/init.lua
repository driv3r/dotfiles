require('plugins')

local set = vim.opt

-- Set Buckup directory
-- ------------------------------------------------------
local backupdir = vim.fn.expand(vim.fn.stdpath('data') , '/backup')
if not vim.fn.isdirectory(backupdir) then
  vim.fn.mkdir(backupdir, "p")
end

set.backupdir = backupdir


-- Tab == 2 soft spaces
-- ------------------------------------------------------
set.expandtab   = true
set.shiftwidth  = 2
set.softtabstop = 2
set.tabstop     = 2


-- While in GOLang use tabs
-- au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4


-- Color Scheme
-- ------------------------------------------------------
if vim.fn.has('termguicolors') then
 set.termguicolors = true
end

vim.cmd('colorscheme shades_of_purple')
vim.o.background = 'dark'
vim.o.syntax = true
vim.g.shades_of_purple_lightline = true


-- Search
-- ------------------------------------------------------
set.showmatch = true
set.hlsearch  = true   -- highlight all search matches
set.smartcase = true   -- pay attention to case when caps are used
set.incsearch = true   -- show search results as I type


-- Enable pasting from external applications like a web browser
-- ------------------------------------------------------
set.pastetoggle = '<F3>'


-- Others
-- ------------------------------------------------------
set.ruler      = true      -- show row and column in footer
set.scrolloff  = 2         -- minimum lines above/below cursor
set.laststatus = 2         -- always show status bar

set.clipboard  = 'unnamed' -- use the system clipboard
set.number     = true      -- Show line numbers
set.autoindent = true      -- Indentation settings
set.wildmenu   = true


-- Show invisible characters
--
set.list = true
set.listchars = {
  tab      = '▸ ',
  trail    = '-',
  extends  = '>',
  precedes = '<',
  nbsp     = '+',
}


-- Pesky typos
--
vim.keymap.set('c', 'WQ', 'wq')
vim.keymap.set('c', 'Wq', 'wq')
vim.keymap.set('c', 'W', 'w')
vim.keymap.set('c', 'Q', 'q')
vim.keymap.set('c', 'Tabe', 'tabe')


-- Delete trailing whitespace
--
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})


-- FZF
--
vim.keymap.set('n', '<leader>p', '<cmd>Files<cr>')
vim.keymap.set('n', '<leader>r', '<cmd>Tags<cr>')
vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore sorbet -g ""'

require('nvim-web-devicons').setup({})

-- Lualine
--
vim.opt.showmode = false

require('lualine').setup({
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
  },
})


-- Smart syntax highlight with treesitter
--
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'css',
    'go',
    'javascript',
    'json',
    'lua',
    'ruby',
    'rust',
    'tsx',
    'typescript',
  },
  auto_install = true,
})


-- disable netrw at the very start of your init.lua (strongly advised)
--
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    -- See :help nvim-tree.api
    local api = require('nvim-tree.api')

    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  end
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')


-- LSP Servers
--
-- Automatically install LSPs
require('neodev').setup({})
require('mason').setup()
require('mason-lspconfig').setup()

-- LSPs setup
local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

-- lspconfig.solargraph.setup({})
-- lspconfig.sorbet.setup({})
lspconfig.ruby_ls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})
lspconfig.jsonls.setup({})
lspconfig.tsserver.setup({})
lspconfig.dockerls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.lua_ls.setup({})


-- Vim CMP
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
--
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },

  window = {
    documentation = cmp.config.window.bordered()
  },

  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },

  mapping = {
    -- Confirm selection.
    ['<CR>'] = cmp.mapping.confirm({select = true}),

    -- Cancel completion.
    ['<C-e>'] = cmp.mapping.abort(),

    -- Move between completion items.
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    -- Scroll text in the documentation window.
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Jump to the next placeholder in the snippet.
    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    -- Jump to the previous placeholder in the snippet.
    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    -- Autocomplete with tab.
    --
    -- - If the completion menu is visible, move to the next item.
    -- - If the line is "empty", insert a Tab character.
    -- - If the cursor is inside a word, trigger the completion menu.
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    -- If the completion menu is visible, move to the previous item.
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  }
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)
