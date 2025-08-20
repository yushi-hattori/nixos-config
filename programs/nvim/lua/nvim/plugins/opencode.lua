return {
  "opencode.nvim",
  keys = {
    { "<leader>aa", "<cmd>lua require('opencode').ask()<CR>", desc = "[O]pencode [A]sk", mode = { "n", "v" } },
    {
      "<leader>aA",
      "<cmd>lua require('opencode').ask('@file ')<CR>",
      desc = "[O]pencode [A]bout file",
      mode = { "n", "v" },
    },
    {
      "<leader>ae",
      "<cmd>lua require('opencode').prompt('Explain @cursor and its context')<CR>",
      desc = "[O]pencode [E]xplain",
    },
    {
      "<leader>ar",
      "<cmd>lua require('opencode').prompt('Review @file for correctness and readability')<CR>",
      desc = "[O]pencode [R]eview",
    },
    { "<leader>af", "<cmd>lua require('opencode').prompt('Fix these @diagnostics')<CR>", desc = "[O]pencode [F]ix" },
    {
      "<leader>ao",
      "<cmd>lua require('opencode').prompt('Optimize @selection for performance and readability')<CR>",
      desc = "[O]pencode [O]ptimize",
      mode = "v",
    },
    {
      "<leader>ad",
      "<cmd>lua require('opencode').prompt('Add documentation comments for @selection')<CR>",
      desc = "[O]pencode [D]ocument",
      mode = "v",
    },
    {
      "<leader>at",
      "<cmd>lua require('opencode').prompt('Add tests for @selection')<CR>",
      desc = "[O]pencode [T]est",
      mode = "v",
    },
  },
  load = function()
    require("opencode").setup({})
  end,
}
