-- Sets up the auto rename for mini files and oil--
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions.type == "move" then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})

-- Sets up the Scratch buffers
vim.keymap.set('n', '<leader>.', function()
  Snacks.scratch()
end, { desc = 'Toggle Scratch Buffer' })

vim.keymap.set('n', '<leader>S', function()
  Snacks.scratch.select()
end, { desc = 'Select Scratch Buffer' })

-- Opens floating terminal
vim.keymap.set('n', '<leader>ft', function()
  Snacks.terminal(nil, { win = { position = "float" } })
end, { desc = 'Open Floating Snacks Terminal' })

require('snacks').setup({
  animate = { enabled = true },
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  debug = { enabled = true },
  -- dim = { enabled = true },
  -- explorer = { enabled = true },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  -- image = { enabled = true },
  layout = { enabled = true },
  lazygit = { enabled = true },
  notifier = { enabled = true },
  profiler = { enabled = true },
  bufdelete = { enabled = true },
  rename = { enabled = true },
  scratch = { enabled = true },
  scroll = { enabled = true, animate = { duration = { step = 20, total = 75 }, easing = "linear" } },
  statuscolumn = { enabled = true },
  terminal = { enabled = true, win = { position = "float" } },
  scope = { enabled = true },
  indent = { enabled = true },
  gitbrowse = { enabled = true },
})
