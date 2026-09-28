require("config.lazy")
require("config.keymaps")
require("config.colorscheme")

----- Vim settings -----
---- Nice colors
vim.opt.termguicolors = true
---- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

---- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

---- UI
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 0

---- Wrapping text
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

---- Runtime path stuff
vim.opt.rtp:append("/Users/samhigh/.local/share/nvim/site/")

---- Terminal stuff
local term_group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })

-- Enter insert mode when opening a new terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = term_group,
  command = "startinsert",
})

-- Enter insert mode when focusing or switching back to a terminal window
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = term_group,
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

---- Templates for different files types
local function load_template(file_pattern, template_file)
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = file_pattern,
    callback = function()
      local template_path = vim.fn.expand("~/.config/nvim/templates/" .. template_file)
      -- "0r" a file from line 0 into the buffer
      vim.cmd("0r " .. template_path)
      -- Find cursor locator if it exists in template and move to it
      local line_number = vim.fn.search("{{cursor}}", "w")
      if line_number > 0 then
        vim.cmd("normal d2f}")
      end
    end
  })
end

load_template("*.html", "skeleton.html")
