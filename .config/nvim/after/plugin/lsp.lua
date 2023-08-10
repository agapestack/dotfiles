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
  'pylsp',
  'jedi_language_server',
  'sqlls',
  'tailwindcss',
  'yamlls'
})

lsp.setup()
