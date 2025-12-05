return {
  {
    'rustaceanvim',
  },
  {
    'baconvim',
    ft = 'rust',
    after = function(_)
      require('bacon').setup()
    end,
  },
}
