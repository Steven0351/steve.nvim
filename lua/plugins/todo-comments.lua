return {
  {
    'todo-comments.nvim',
    for_cat = 'ui',
    event = 'DeferredUIEnter',
    after = function(_)
      require('todo-comments').setup {
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
      }
    end,
  },
}
