return {
  "OXY2DEV/markview.nvim",
  load = function()
    require("markview").setup({
      filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante", "snacks"},
      buf_ignore = {},
      max_length = 99999,
    })
  end,
}
