-- Fix the line numbers color going above the line up here
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup{
      options = {
        mode = "buffer",
        -- "slant", "padded_slant", "block", "thin"
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        show_buffer_icons = true,
      },
      highlights = {
        buffer_selected = {
          fg = "#cacaca", 
          bg = "#282828",
          bold = true,
          italic = false,
        },
        background = {
          fg = "#686868", 
          bg = "#202020",
        },
        fill = {
          fg = "#202020", 
          bg = "#202020",
        },
        separator = {
          fg = "#202020", 
          bg = "#202020",
        },
        modified = {
          fg = "#686868",
          bg = "#202020",
        },
        modified_visible = {
          fg = "#686868",
          bg = "#202020",
        },
        modified_selected = {
          fg = "#cacaca",
          bg = "#282828",
        },
        duplicate = {
          fg = "#686868",
          bg = "#202020",
        },
        duplicate_visible = {
          fg = "#686868",
          bg = "#202020",
        },
        duplicate_selected = {
          fg = "#cacaca",
          bg = "#282828",
          bold = false,
        },
      },
    }
  end
}
