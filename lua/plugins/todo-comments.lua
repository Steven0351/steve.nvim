return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    keywords = {
      QUESTION = {
        icon = '󱍋 ',
        color = 'hint',
      },
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
