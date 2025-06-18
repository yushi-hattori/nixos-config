return {
  "leetcode.nvim",
  for_cat = "general.extra",
  event = "DeferredUIEnter",
  after = function(plugin)
    require("leetcode").setup({
      lang = "python3",
      theme = {
        ["normal"] = {
          fg = "#BE95FF",
        },
      },
    })
  end,
}
