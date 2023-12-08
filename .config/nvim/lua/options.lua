vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.laststatus = 4
vim.opt.autowrite = true -- save the file before leaving if changed
vim.opt.autoread = true -- auto load file changes occured outside vim
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true -- round indent to sw compatible
vim.opt.expandtab = true

vim.opt.guifont = "RobotoMono Nerd Font:h14"

vim.opt.clipboard = 'unnamedplus'

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

