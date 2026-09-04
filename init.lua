require("config.lazy")
require("config.keymaps")
require("config.colorscheme")

-- Vim Settings
-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- UI
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

-- Wrapping text
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

-- Runtime Path Stuff
vim.opt.rtp:append("/Users/samhigh/.local/share/nvim/site/")
