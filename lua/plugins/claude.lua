return {
  {
    'claudecode-nvim',
    for_cat = 'ai',
    event = 'DeferredUIEnter',
    after = function(_)
      require('claudecode').setup {
        terminal = {
          provider = 'none',
        },
      }
    end,
  },
}
