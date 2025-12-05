return {
  {
    'colorizer',
    after = function(_)
      require('colorizer').setup {
        user_default_options = {
          names = false,
          mode = 'virtualtext',
          virtualtext = ' ',
          virtualtext_inline = 'before',
        },
      }
    end,
  },
}
