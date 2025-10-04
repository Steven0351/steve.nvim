return {
  {
    'guess-indent.nvim',
    for_cat = 'general',
    after = function(_)
      require('guess-indent').setup {}
    end,
  },
}
