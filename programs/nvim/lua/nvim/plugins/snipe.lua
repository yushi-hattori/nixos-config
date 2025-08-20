-- vim.keymap.set("n", "<C-f>", function()
--
-- end, { desc = "Open Snipe" })
-- require("snipe").setup({})
return {
  "snipe",
  enabled = true,
  event = "DeferredUIEnter",
  keys = {
    {
      "<C-f>",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
  load = function()
    require("snipe").setup({
      ui = {
        position = "center",
        open_win_override = {
          border = "rounded",
        },
        preselect_current = true,
        text_align = "file-first",
      },
      navigate = {
        cancel_snipe = "q",
      },
      sort = "last",
    })
  end,
}
