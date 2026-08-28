-- Gets rid of highlighting after search and replace.
vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>")

-- Centers the cursor when using down page and up page commands
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- File explorer command
vim.keymap.set("n", "<leader>p", "<Cmd>Ex<CR>")

-- Telescope Keymaps
local telescope_functions = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_functions.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_functions.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_functions.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_functions.help_tags, { desc = 'Telescope help tags' })
