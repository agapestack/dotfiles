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

-- FLOATERM
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- BARBAR
map('n', '<S-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<S-l>', '<Cmd>BufferNext<CR>', opts)

-- NVIM-TREE
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
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', telescope.find_files, {}) -- find
vim.keymap.set('n', '<leader>p', function()
  builtin.grep_string({search = vim.fn.input("Grep > ") });
end) -- search Project file with grep
-- vim.keymap.set('n', '<leader>g', builtin.git_files, {}) -- search in the Git project files name
-- vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

