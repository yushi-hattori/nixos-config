local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
  colorschemeName = "onedark"
end
vim.cmd.colorscheme(colorschemeName)

require("nvim.plugins.notify")

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
  { import = "nvim.plugins.leetcode" },
  { import = "nvim.plugins.telescope" },
  { import = "nvim.plugins.treesitter" },
  { import = "nvim.plugins.completion" },
  { import = "nvim.plugins.mini" },
  { import = "nvim.plugins.zellij-nav" },
  { import = "nvim.plugins.snipe" },
  { import = "nvim.plugins.smear-cursor" },
  { import = "nvim.plugins.opencode" },
  -- { import = "nvim.plugins.avante" },
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
