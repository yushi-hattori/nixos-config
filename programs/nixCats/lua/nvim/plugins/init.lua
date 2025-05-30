local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
  colorschemeName = "onedark"
end
-- Could I lazy load on colorscheme with lze?
-- sure. But I was going to call vim.cmd.colorscheme() during startup anyway
-- this is just an example, feel free to do a better job!
vim.cmd.colorscheme(colorschemeName)

local ok, notify = pcall(require, "notify")
if ok then
  notify.setup({
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  })
  vim.notify = notify
  vim.keymap.set("n", "<Esc>", function()
    notify.dismiss({ silent = true })
  end, { desc = "dismiss notify popup and clear hlsearch" })
end

-- NOTE: you can check if you included the category with the thing wherever you want.
if nixCats("general.extra") then
  -- I didnt want to bother with lazy loading this.
  -- I could put it in opt and put it in a spec anyway
  -- and then not set any handlers and it would load at startup,
  -- but why... I guess I could make it load
  -- after the other lze definitions in the next call using priority value?
  -- didnt seem necessary.
  vim.g.loaded_netrwPlugin = 1
end

require("nvim.plugins.snacks")
require("nvim.plugins.noice")
require("lze").load({
  -- { import = "nvim.plugins.telescope", },
  { import = "nvim.plugins.treesitter" },
  { import = "nvim.plugins.completion" },
  { import = "nvim.plugins.mini" },
  { import = "nvim.plugins.zellij-nav" },
  { import = "nvim.plugins.snipe" },
  { import = "nvim.plugins.smear-cursor" },
  { import = "nvim.plugins.avante" },
  { import = "nvim.plugins.markview" },
  { import = "nvim.plugins.markdown-preview" },
  { import = "nvim.plugins.undotree" },
  { import = "nvim.plugins.comment" },
  { import = "nvim.plugins.blankline" },
  { import = "nvim.plugins.surround" },
  { import = "nvim.plugins.vim-startuptime" },
  { import = "nvim.plugins.fidget" },
  { import = "nvim.plugins.lualine" },
  { import = "nvim.plugins.gitsigns" },
  { import = "nvim.plugins.whichkey" },
})
