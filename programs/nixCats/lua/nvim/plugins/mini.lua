return {
  {
    'mini.nvim',
    enabled = true,
    event   = "DeferredUIEnter",
    after   = function(plugin)
      -- Better Around/Inide textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      require('mini.move').setup()
      require('mini.operators').setup()
      require('mini.pairs').setup()
      require('mini.snippets').setup()
      require('mini.bracketed').setup()
      require('mini.jump').setup()
      require('mini.jump2d').setup()
      require('mini.sessions').setup()
      require('mini.visits').setup()
      -- require('mini.animate').setup({})

      -- MiniFiles
      -- vim.keymap.set('n', '<leader>o', ':lua MiniFiles.open()<CR>', { desc = 'Open [F]iles' })
      vim.keymap.set("n", "<leader>o", function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
        MiniFiles.open(path)
        MiniFiles.reveal_cwd()
      end, { desc = "Open Mini Files" })

      require('mini.files').setup({
        windows = {
          preview = true,
          width_preview = 100,
        }
      })
    end,
  }
}
