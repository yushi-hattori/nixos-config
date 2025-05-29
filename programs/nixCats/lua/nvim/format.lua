require("lze").load({
  {
    "conform.nvim",
    for_cat = "format",
    keys = {
      { "<leader>FF", desc = "[F]ormat [F]ile" },
    },
    -- colorscheme = "",
    after = function(plugin)
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          -- NOTE: download some formatters in lspsAndRuntimeDeps
          -- and configure them here
          lua = { "stylua" },
          nix = { "alejandra" },
          javascript = { { "prettierd", "prettier", stop_after_first = true } },
          typescript = { { "prettierd", "prettier", stop_after_first = true } },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = { timeout_ms = 500 },
        formatters = {
          stylua = {
            args = {
              "--search-parent-directories",
              "--indent-type",
              "Spaces",
              "--indent-width",
              "2",
              "--stdin-filepath",
              "$FILENAME",
              "-",
            },
          },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>FF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "[F]ormat [F]ile" })
    end,
  },
})
