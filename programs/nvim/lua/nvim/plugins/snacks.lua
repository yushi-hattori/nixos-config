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

-- picker
vim.keymap.set("n", "-", function() Snacks.explorer.open() end, { desc = 'Snacks Explorer' })
vim.keymap.set("n", "<c-\\>", function() Snacks.terminal.open() end, { desc = 'Snacks Terminal' })
vim.keymap.set("n", "<leader>_", function() Snacks.lazygit.open() end, { desc = 'Snacks LazyGit' })
vim.keymap.set('n', "<leader>sf", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
vim.keymap.set('n', "<leader><leader>s", function() Snacks.picker.buffers() end, { desc = "Search Buffers" })
-- find
vim.keymap.set('n', "<leader>sF", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set('n', "<leader>sg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
-- Grep
vim.keymap.set('n', "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set('n', "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
vim.keymap.set('n', "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end,
  { desc = "Visual selection or word" })
-- search
vim.keymap.set('n', "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set('n', "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set('n', "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set('n', "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set('n', "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set('n', "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set('n', "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set('n', "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set('n', "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
vim.keymap.set('n', "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set('n', "<leader>sr", function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set('n', "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
vim.keymap.set('n', "<leader>sn", function() Snacks.picker.notifications() end, { desc = "Notification History" })
vim.keymap.set('n', "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set('n', "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set('n', "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
-- vim.keymap.set('n', "gr", function() Snacks.picker.lsp_references() end, nowait = true, { desc = "References" })
vim.keymap.set('n', "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set('n', "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
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
  picker = {
    win = {
      input = {
        keys = {
          ["<C-c>"] = "cancel",
        }
      }
    },
    debug = {
      grep = true
    }
    
  },
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
