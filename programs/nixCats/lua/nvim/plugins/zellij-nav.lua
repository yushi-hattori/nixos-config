return {
  {
    'zellij-nav.nvim',
    enabled = true,
    event   = "DeferredUIEnter",
    keys    = {
      -- { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab" } },
      -- { "<c-j>", "<cmd>ZellijNavigateDown<cr>",     { silent = true, desc = "navigate down" } },
      -- { "<c-k>", "<cmd>ZellijNavigateUp<cr>",       { silent = true, desc = "navigate up" } },
      -- { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
    },
    after   = function(plugin)
      require('zellij-nav').setup()
      -- NOTE: Ensures that when exiting NeoVim, Zellij returns to normal mode
      vim.api.nvim_create_autocmd("VimLeave", {
        pattern = "*",
        command = "silent !zellij action switch-mode normal"
      })
      vim.api.nvim_set_keymap("n", "<A-h>", "<cmd>ZellijNavigateLeft<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>ZellijNavigateDown<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>ZellijNavigateUp<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-l>", "<cmd>ZellijNavigateRight<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-n>", "<cmd>ZellijNewPane<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-s>", "<cmd>ZellijNewPaneSplit<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-v>", "<cmd>ZellijNewPaneVSplit<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-x>", "<cmd>ZellijClosePane<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<A-t>", "<cmd>ZellijNewTab<CR>", { silent = true })
    end
  }
}
