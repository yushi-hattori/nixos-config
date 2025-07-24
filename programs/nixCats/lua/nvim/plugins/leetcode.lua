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

    -- Set keybindings for Leet run and submit
    vim.keymap.set("n", "<leader>lo", ":Leet <CR>", { noremap = true, silent = true, desc = "[L]eetcode [O]pen" })
    vim.keymap.set("n", "<leader>lr", ":Leet run<CR>", { noremap = true, silent = true, desc = "[L]eetcode [R]un" })
    vim.keymap.set(
      "n",
      "<leader>ls",
      ":Leet submit<CR>",
      { noremap = true, silent = true, desc = "[L]eetcode [S]ubmit" }
    )
    vim.keymap.set(
      "n",
      "<leader>lc",
      ":Leet console<CR>",
      { noremap = true, silent = true, desc = "[L]eetcode [C]onsole" }
    )
    vim.keymap.set("n", "<leader>li", ":Leet info<CR>", { noremap = true, silent = true, desc = "[L]eetcode [I]nfo" })
    vim.keymap.set("n", "<leader>lt", ":Leet tabs<CR>", { noremap = true, silent = true, desc = "[L]eetcode [T]abs" })
  end,
}
