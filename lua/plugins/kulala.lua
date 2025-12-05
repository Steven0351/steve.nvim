return {
  {
    'kulala-nvim',
    ft = { 'http', 'rest' },
    after = function(_)
      require('kulala').setup {
        global_keymaps = true,
        global_keymaps_prefix = '<leader>k',
      }
    end,
  },
}
