return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    keywords = {
      NOTE = {
        icon = '󰎞 ',
      },
      HACK = {
        icon = ' ',
        color = 'error',
      },
    },
  },
}
