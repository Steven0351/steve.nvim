return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  main = 'colorizer',
  opts = { -- set to setup table
    user_default_options = {
      names = false,
    },
  },
}
