return {
  {
    'snacks.nvim',
    after = function(_)
      require('snacks').setup {
        bigfile = {
          enabled = true,
        },
        image = {
          enabled = true,
        },
        indent = {
          enabled = true,
        },
        input = {
          enabled = true,
        },
        notifier = {
          enabled = true,
        },
        picker = {
          enabled = true,
        },
        rename = {
          enabled = true,
        },
        statuscolumn = {
          enabled = true,
        },
        terminal = {
          enabled = true,
        },
        words = {
          enabled = true,
        },
      }

      vim.keymap.set('n', '<leader><space>', function()
        Snacks.picker.smart()
      end, { desc = 'Smart Find files' })

      vim.keymap.set('n', '<leader>,', function()
        Snacks.picker.buffers()
      end, { desc = 'Buffers' })

      vim.keymap.set('n', '<leader>/', function()
        Snacks.picker.grep()
      end, { desc = 'Grep' })

      vim.keymap.set('n', '<leader>e', function()
        Snacks.explorer()
      end, { desc = 'File explorer' })

      vim.keymap.set('n', '<leader>ff', function()
        Snacks.picker.files()
      end, { desc = 'Find Files' })

      vim.keymap.set('n', '<leader>fb', function()
        Snacks.picker.buffers()
      end, { desc = 'Find Buffers' })

      vim.keymap.set('n', '<leader>fm', function()
        Snacks.picker.marks()
      end, { desc = 'Find marks' })

      vim.keymap.set('n', '<leader>tt', function()
        Snacks.terminal.toggle()
      end, { desc = 'Toggle Terminal' })
    end,
  },
}
