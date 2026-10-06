----- Null keybinds -----
-- These are just keybinds that are duplicate and null them to nothing
vim.keymap.set("n", "<C-q>", "", { desc = "Duplicate visual block keybind" })

----- Regular vim commands -----

-- Gets rid of highlighting after search and replace.
vim.keymap.set("n", "<C-n>", "<CMD>noh<CR>", { desc = "Remove search highlight" })

-- Centers the cursor when using down page and up page commands
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centers cursor when moving down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centers cursor when moving up" })

-- File explorer command
vim.keymap.set("n", "<LEADER>p", "<CMD>Ex<CR>", { desc = "Opens file explorer" })

-- Terminal commands
-- vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Window swapping from terminal" })

-- Window resizing commands because using + with shift sucks
vim.keymap.set("n", "<C-w>=", "<C-w>+", { desc = "Increases window height" })
vim.keymap.set("n", "<C-w>,", "<C-w><", { desc = "Decreases window width" })
vim.keymap.set("n", "<C-w>.", "<C-w>>", { desc = "Increases window width" })
vim.keymap.set("n", "<C-w>\\", "<C-w>=", { desc = "Equalizes window size" })
vim.keymap.set("n", "<C-\\><C-\\>", ":bd<CR>", { desc = "Delete current buffer" })
-- Buffer commands
vim.keymap.set("n", "<S-l>", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-\\><C-\\>", ":bd<CR>", { desc = "Delete current buffer" })
vim.keymap.set("t", "<C-\\><C-\\>", ":bd!<CR>", { desc = "Delete current terminal buffer" })

-- Wrapping text commands
vim.keymap.set("n", "tw", function()
  vim.cmd("set wrap!")
  local on = vim.opt.wrap:get() 
  print("Toggled wrapped text " .. (on and "on" or "off"))
end,
{ desc = "Toggle wrapping of text" })

-- Evaluting selected equation
vim.keymap.set("v", "<LEADER>=", '"cc<C-r>=<C-r>c<CR><ESC>', { desc = "Evaluates the current selected expression" })

----- Plugin commands -----
-- Telescope Keymaps
local telescope_functions = require("telescope.builtin")
vim.keymap.set("n", "<LEADER>ff", telescope_functions.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<LEADER>fg", telescope_functions.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<LEADER>fb", telescope_functions.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<LEADER>fh", telescope_functions.help_tags, { desc = "Telescope help tags" })

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
end,
{ desc = "Toggle left gutter warnings" })

vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })
vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to function definition" })
vim.keymap.set("n", "gf", function() vim.diagnostic.open_float() end, { desc = "Opens floating warning description window" })
vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, { desc = "Executes a code action under cursor" })
vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, { desc = "Displays a markdown floating box showing type information and documentation" })

----- Custom commands -----
---- Wrapping HTML commands
-- Wrap Tag
vim.keymap.set("n", "<LEADER>wt", "^\"wd$a<<ESC>\"wpa></<ESC>\"wpa><ESC>F>", { desc = "Wrap HTML tag (only text on line)" })
vim.keymap.set("v", "<LEADER>wt", "\"wda<<ESC>\"wpa></<ESC>\"wpa><ESC>F>", { desc = "Wrap HTML tag (highlighted)" })
-- Wrap Save
vim.keymap.set("v", "<LEADER>ws", "\"wd", { desc = "Save the current selection as wrapper" })
-- Wrap Execute
vim.keymap.set("n", "<LEADER>we", "^i<<ESC>\"wpa><ESC>$a</<ESC>\"wpa><ESC>F>", { desc = "Wrap text with HTML tag saved using Wrap Save (all text on line)" })
vim.keymap.set("v", "<LEADER>we", "di<<ESC>\"wpa><ESC>pa</<ESC>\"wpa><ESC>F>", { desc = "Wrap text with HTML tag saved using Wrap Save" })

----- Trash -----
-- Buffer commands because using :b is weird?
-- vim.keymap.set("n", "<C-b>n", "<CMD>bn<CR>", desc = "Next buffer")
-- vim.keymap.set("n", "<C-b>p", "<CMD>bp<CR>", desc = "Previous buffer")
-- vim.keymap.set("n", "<C-b>d", "<CMD>bd<CR>", desc = "Delete current buffer")

-- Tab commands because using :tab is weird?
-- vim.keymap.set("n", "<C-t>n", "<CMD>tabnew<CR>", desc = "New tab")
-- vim.keymap.set("n", "<C-t>c", "<CMD>tabclose<CR>", desc = "Close current tab")

