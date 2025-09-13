return {
  {
    'mini.cursorword',
    after = function(_)
      require('mini.cursorword').setup()
    end,
  },
  {
    'mini.icons',
    after = function(_)
      require('mini.icons').setup()
      ---@module 'mini.icons'
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    'mini.pairs',
    after = function(_)
      require('mini.pairs').setup()
    end,
  },
  {
    'mini.files',
    after = function(_)
      local files = require 'mini.files'
      files.setup()
      vim.keymap.set('n', '<leader>mf', MiniFiles.open, { desc = 'Mini Files' })
    end,
  },
  {
    'mini.surround',
    after = function(_)
      require('mini.surround').setup()
    end,
  },
  {
    'nvim-treesitter-textobjects',
    dep_of = 'mini.ai',
  },
  {
    'mini.ai',
    event = 'DeferredUIEnter',
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {
          m = spec_treesitter {
            a = '@function.outer',
            i = '@function.inner',
          },
          C = spec_treesitter {
            a = '@comment.outer',
            i = '@comment.inner',
          },
          -- there is a built-in for a function call on 'f', but this may be more accurate
          c = spec_treesitter {
            a = '@call.outer',
            i = '@call.inner',
          },
          -- i is for if
          i = spec_treesitter {
            a = '@conditional.outer',
            i = '@conditional.inner',
          },
          L = spec_treesitter {
            a = '@loop.outer',
            i = '@loop.inner',
          },
        },
      }
    end,
  },
}
