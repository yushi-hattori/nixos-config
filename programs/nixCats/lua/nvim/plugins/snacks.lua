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

-- Opens LazyGit
vim.keymap.set('n', '<leader>gl', function()
  Snacks.lazygit()
end, { desc = 'Open Lazygit' })

-- Same help function and :H command as before
local M = {}
local function open_help_snack(tag)
  if not tag or tag == "" then return end

  local tagfile = vim.fn.globpath(vim.o.runtimepath, "doc/tags", false, true)
  local tagline = nil

  for _, file in ipairs(tagfile) do
    for line in io.lines(file) do
      local t, file_path, cmd = line:match("([^\t]+)\t([^\t]+)\t(.+)")
      if t == tag then
        tagline = { file_path = file_path, cmd = cmd }
        break
      end
    end
    if tagline then break end
  end

  if not tagline then
    vim.notify("Help tag not found: " .. tag, vim.log.levels.ERROR)
    return
  end

  local doc_paths = vim.api.nvim_get_runtime_file("doc/" .. tagline.file_path, false)
  local help_file = doc_paths[1]
  if not help_file then
    vim.notify("Help file not found: " .. tagline.file_path, vim.log.levels.ERROR)
    return
  end

  Snacks.win({
    file = help_file,
    width = 0.9,
    height = 0.9,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
    cursor = { tagline.cmd:match("/%^(.-)%$/") or 1, 0 },
  })
end

M.open_help_snack = open_help_snack

-- Create :H command with help completion
vim.api.nvim_create_user_command("H", function(opts)
  open_help_snack(opts.args)
end, {
  nargs = 1,
  complete = "help",
})

-- Map <leader>h to simulate typing ":H "
vim.keymap.set("n", "<leader>h", function()
  vim.api.nvim_feedkeys(":H ", "n", false)
end, { desc = "Open :H with help completion" })


require('snacks').setup({
  animate = { enabled = true },
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      {
        pane = 2,
        section = "terminal",
        cmd = "",
        height = 5,
        padding = 1,
      },
      { section = "keys", gap = 1, padding = 1 },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
      { section = "startup" },
    },
  },
  debug = { enabled = true },
  -- dim = { enabled = true },
  -- explorer = { enabled = true },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  -- image = { enabled = true },
  layout = { enabled = true },
  lazygit = { enabled = true },
  notifier = { enabled = true },
  -- profiler = { enabled = false },
  bufdelete = { enabled = true },
  rename = { enabled = true },
  scratch = { enabled = true },
  scroll = { enabled = false, animate = { duration = { step = 20, total = 75 }, easing = "linear" } },
  statuscolumn = { enabled = true },
  terminal = { enabled = true, win = { position = "float" } },
  scope = { enabled = true },
  indent = { enabled = true },
  gitbrowse = { enabled = true },
  win = { enabled = true },
})

return M
