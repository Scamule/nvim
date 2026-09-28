----- Null keybinds -----
-- These are just keybinds that are duplicate and null them to nothing
vim.keymap.set("n", "<C-q>", "", { desc = "Duplicate visual block keybind" })

----- Regular vim commands -----

-- Gets rid of highlighting after search and replace.
vim.keymap.set("n", "<C-n>", "<Cmd>noh<CR>", { desc = "Remove search highlight" })

-- Centers the cursor when using down page and up page commands
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centers cursor when moving down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centers cursor when moving up" })

-- File explorer command
vim.keymap.set("n", "<leader>p", "<Cmd>Ex<CR>", { desc = "Opens file explorer" })

-- Terminal commands
-- vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Window swapping from terminal" })
-- vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = "term://*",
--     command = "startinsert"
-- })

-- Window resizing commands because using + with shift sucks
vim.keymap.set("n", "<C-w>=", "<C-w>+", { desc = "Increases window height" })
vim.keymap.set("n", "<C-w>,", "<C-w><", { desc = "Decreases window width" })
vim.keymap.set("n", "<C-w>.", "<C-w>>", { desc = "Increases window width" })
vim.keymap.set("n", "<C-w>\\", "<C-w>=", { desc = "Equalizes window size" })

-- Buffer commands
vim.keymap.set("n", "<S-l>", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-\\><C-\\>", ":bd<CR>", { desc = "Delete current buffer" })
vim.keymap.set("t", "<C-\\><C-\\>", ":bd!<CR>", { desc = "Delete current terminal buffer" })

----- Plugin commands -----
-- Telescope Keymaps
local telescope_functions = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_functions.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope_functions.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope_functions.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope_functions.help_tags, { desc = "Telescope help tags" })

-- LSP Commands / Options
vim.keymap.set("n", "gw", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not current,
    underline = not current,
  })
  print("Warnings " .. (not current and "on" or "off"))
end, { desc = "Toggle warnings" })
vim.keymap.set("n", "gl", function()
  local current = vim.diagnostic.config().signs
  vim.diagnostic.config({
    signs = not current,
  })
  print("Left gutter warnings " .. (not current and "on" or "off"))
end, { desc = "Toggle left gutter warnings" })

vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })
vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to function definition" })
vim.keymap.set("n", "gf", function() vim.diagnostic.open_float() end, { desc = "Opens floating warning description window" })
vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, { desc = "Executes a code action under cursor" })
vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, { desc = "Displays a markdown floating box showing type information and documentation" })

----- Custom commands -----
---- Wrapping HTML commands
-- Wrap Tag
vim.keymap.set("n", "<leader>wt", "^\"wd$a<<Esc>\"wpa></<Esc>\"wpa><Esc>F>", { desc = "Wrap HTML tag (only text on line)" })
vim.keymap.set("v", "<leader>wt", "\"wda<<Esc>\"wpa></<Esc>\"wpa><Esc>F>", { desc = "Wrap HTML tag (highlighted)" })
-- Wrap Save
vim.keymap.set("v", "<leader>ws", "\"wd", { desc = "Save the current selection as wrapper" })
-- Wrap Execute
vim.keymap.set("n", "<leader>we", "^i<<Esc>\"wpa><Esc>$a</<Esc>\"wpa><Esc>F>", { desc = "Wrap text with HTML tag saved using Wrap Save (all text on line)" })
vim.keymap.set("v", "<leader>we", "di<<Esc>\"wpa><Esc>pa</<Esc>\"wpa><Esc>F>", { desc = "Wrap text with HTML tag saved using Wrap Save" })


----- Trash -----
-- Buffer commands because using :b is weird?
-- vim.keymap.set("n", "<C-b>n", "<Cmd>bn<CR>", desc = "Next buffer")
-- vim.keymap.set("n", "<C-b>p", "<Cmd>bp<CR>", desc = "Previous buffer")
-- vim.keymap.set("n", "<C-b>d", "<Cmd>bd<CR>", desc = "Delete current buffer")

-- Tab commands because using :tab is weird?
-- vim.keymap.set("n", "<C-t>n", "<Cmd>tabnew<CR>", desc = "New tab")
-- vim.keymap.set("n", "<C-t>c", "<Cmd>tabclose<CR>", desc = "Close current tab")
-- vim.keymap.set("n", "<C-t>m", "<Cmd>tabmove<CR>", desc = "Move current tab")
