return {
  {
    'render-markdown.nvim',
    for_cat = 'general',
    after = function(_)
      require('render-markdown').setup {
        file_types = { 'markdown', 'Avante' },
      }
    end,
    ft = { 'markdown', 'Avante' },
  },
}
