local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.opt.termguicolors = true

-- SPELL CHECK
map("n", "<F2>", ":set spell!<cr>")

-- EDITORCONFIG

-- Quick editor configuration --> when not using a .editorconfig
map('n', '<leader>4', '<Cmd>:set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>')
map('n', '<leader>2', '<Cmd>:set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>')

-- FLOATERM
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- BARBAR
map('n', '<S-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<S-l>', '<Cmd>BufferNext<CR>', opts)
map('n', '<A-1>', '<Cmd>BufferGoto1<CR>')
map('n', '<A-2>', '<Cmd>BufferGoto2<CR>')
map('n', '<A-3>', '<Cmd>BufferGoto3<CR>')
map('n', '<A-4>', '<Cmd>BufferGoto4<CR>')
map('n', '<A-5>', '<Cmd>BufferGoto5<CR>')
map('n', '<A-6>', '<Cmd>BufferGoto6<CR>')
map('n', '<A-7>', '<Cmd>BufferGoto7<CR>')
map('n', '<A-8>', '<Cmd>BufferGoto8<CR>')
map('n', '<A-9>', '<Cmd>BufferGoto9<CR>')
map('n', '<A-0>', '<Cmd>BufferLast<CR>')
map('n', '<A-c>', '<Cmd>BufferClose<CR>')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
map('n', '<C-f>', ":NvimTreeToggle<CR>")
map('n', '<C-g>', ":NvimTreeFocus<CR>")
-- :NvimTreeToggle
-- :NvimTreeFocus

-- HOP
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})

-- TELESCOPE
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

