local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {}) -- find
vim.keymap.set('n', '<leader>p', function()
  builtin.grep_string({search = vim.fn.input("Grep > ") });
end) -- search Project file with grep

-- vim.keymap.set('n', '<leader>g', builtin.git_files, {}) -- search in the Git project files name
-- vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

