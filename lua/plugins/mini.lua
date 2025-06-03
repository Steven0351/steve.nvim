return {
  {
    'echasnovski/mini.icons',
    opts = {},
    config = function(opts)
      require('mini.icons').setup(opts)
      ---@module 'mini.icons'
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  { 'echasnovski/mini.surround', opts = {} },
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
}
