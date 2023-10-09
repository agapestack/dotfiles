local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
  -- Replace these with whatever servers you want to install
  'tsserver',
  'eslint',
  'ansiblels',
  'arduino_language_server',
  'bashls',
  'clangd',
  'cmake',
  'cssmodules_ls',
  'dockerls',
  'gopls',
  'html',
  'jsonls',
  'texlab',
  'lua_ls',
  'marksman',
  'jedi_language_server',
  'sqlls',
  'tailwindcss',
  'yamlls'
})

lsp.setup()

-- Custom binding with cmp
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- `Enter` key to configrm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space'] = cmp.mapping.complete(),

    -- Navigate between snipper placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})
