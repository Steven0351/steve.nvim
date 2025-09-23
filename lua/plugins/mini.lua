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
  {
    'mini.clue',
    event = 'DeferredUIEnter',
    after = function(_)
      local miniclue = require 'mini.clue'
      miniclue.setup {
        delay = 500,
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
          {
            { mode = 'n', keys = '<Leader>a', desc = '󱚞 Avante' },
            { mode = 'n', keys = '<Leader>d', desc = ' Debug' },
            { mode = 'n', keys = '<Leader>ds', desc = ' Debug: Step' },
            { mode = 'n', keys = '<Leader>h', desc = ' Git' },
            { mode = 'n', keys = '<Leader>f', desc = '󰍉 Find' },
            { mode = 'n', keys = '<Leader>t', desc = '󰨚 Toggle' },
          },
        },
        window = {
          config = {
            width = 'auto',
            col = 'auto',
            anchor = 'SW',
          },
        },
      }
    end,
  },
}
