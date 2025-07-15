-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'MiniFilesWindowUpdate',
--   callback = function(args)
--     local win = vim.wo[args.data.win_id]
--     win.number = true
--     win.relativenumber = true
--   end,
-- })

---@module 'lazy'
---@type LazySpec
return {
  {
    'echasnovski/mini.files',
    lazy = false,
    dependencies = { 'echasnovski/mini.icons' },
    opts = {},
  },
  {
    'echasnovski/mini.cursorword',
    lazy = false,
    opts = {},
  },
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
  {
    'echasnovski/mini.ai',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {
          m = spec_treesitter {
            a = '@function.outer',
            i = '@function.inner',
          },
          o = spec_treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },
        },
      }
    end,
  },
}
