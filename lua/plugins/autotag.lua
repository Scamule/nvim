-- This plugin is just used for HTML tags
return {
  "windwp/nvim-ts-autotag",
  -- This is nested because the configuration to the version is set up this way
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    }
  }
}
