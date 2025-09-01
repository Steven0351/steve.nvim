return {
  {
    'nvchad-ui',
    priority = 1000,
    after = function(_)
      require 'nvchad'
    end,
  },

  {
    priority = 1000,
    'base46',
    after = function(_)
      require('base46').load_all_highlights()
    end,
  },

  {
    'volt',
    priority = 1000,
  },
}
