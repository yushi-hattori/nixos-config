return {
  "lualine.nvim",
  for_cat = "general.always",
  -- cmd = { "" },
  event = "DeferredUIEnter",
  -- ft = "",
  -- keys = "",
  -- colorscheme = "",
  after = function(plugin)
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = colorschemeName,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
            status = true,
          },
        },
      },
      inactive_sections = {
        lualine_b = {
          {
            "filename",
            path = 3,
            status = true,
          },
        },
        lualine_x = { "filetype" },
      },
      tabline = {
        lualine_a = { "buffers" },
        -- if you use lualine-lsp-progress, I have mine here instead of fidget
        -- lualine_b = { 'lsp_progress', },
        lualine_z = { "tabs" },
      },
    })
  end,
}
