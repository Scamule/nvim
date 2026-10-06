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
config_directory = vim.fn.stdpath("config")
--- Creates template for given file extension
---@param extension string
local function load_template(extension)
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*" .. extension,
    callback = function()
      local template_path = vim.fn.expand(config_directory .. "/templates/template" .. (extension:sub(1, 1) == "." and "" or "-") .. extension )
      -- normal! dG deletes the contents of the file in case it was matched before
      vim.cmd("normal! dG")
      -- "0r" reads a file from line 0 into the buffer
      vim.cmd("0r " .. template_path)
      -- Find macro first
      local line_number = vim.fn.search("{{macro}}", "w")
      if line_number > 0 then
        vim.cmd("normal d2f}")
        vim.cmd("normal \"qy$")
      end
      -- Make a zt locator for nice formating
      line_number = vim.fn.search("{{zt}}", "w")
      if line_number > 0 then
        vim.cmd("normal d2f}")
        vim.cmd("normal zt")
      end
      -- Find cursor locator if it exists in template and move to it
      line_number = vim.fn.search("{{cursor}}", "w")
      if line_number > 0 then
        vim.cmd("normal d2f}")
      end
    end
  })
end

--- Loads all templates in the templates directory
local function load_templates()
  local templates_string = vim.fn.system("ls -1 " .. config_directory .. "/templates")
  local templates = {}
  for line in string.gmatch(templates_string, "[^\r\n]+") do
    table.insert(templates, line)
  end
  -- Sort templates in the order of least to greatest number of '-' characters
  table.sort(templates, function (a, b)
    _, a_length = string.gsub(a, "%-", "")
    _, b_length = string.gsub(b, "%-", "")
    return a_length < b_length
  end)
  for _, filename in ipairs(templates) do
    local extension = string.match(filename, "template%-?(.*)")
    load_template(extension)
  end
end
-- RUN
load_templates()
