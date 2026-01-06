return {
  {
    'conifer',
    priority = 1000,
    after = function(_)
      require('conifer').setup {
        transparent = false,
      }
      vim.cmd 'colorscheme conifer'
    end,
  },
  {
    'zenbones',
  },
  {
    'blackmetal',
  },
}
