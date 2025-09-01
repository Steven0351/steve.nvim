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

      vim.keymap.set('n', '<leader>e', function()
        Snacks.explorer()
      end, { desc = 'File explorer' })
    end,
  },
}
