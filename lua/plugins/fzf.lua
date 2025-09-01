return {
  {
    'fzf-lua',
    event = 'DeferredUIEnter',
    dep_of = 'fzf-lua-frecency',
    after = function(_)
      require('fzf-lua').setup {
        fzf_colors = true,
      }

      vim.keymap.set('n', '<leader><space>', function()
        require('fzf-lua-frecency').frecency {
          cwd_only = true,
        }
      end, { desc = 'Smart Find Files' })

      vim.keymap.set('n', '<leader>p', function()
        FzfLua.global()
      end, { desc = 'Open Palette' })

      vim.keymap.set('n', '<leader>,', function()
        FzfLua.buffers()
      end, { desc = 'Buffers' })

      vim.keymap.set('n', '<leader>/', function()
        FzfLua.grep()
      end, { desc = 'Grep' })

      vim.keymap.set('n', '<leader>fm', function()
        FzfLua.marks()
      end, { desc = 'Find marks' })
    end,
  },
  {
    'fzf-lua-frecency',
    event = 'DeferredUIEnter',
    after = function(_)
      require('fzf-lua-frecency').setup()
    end,
  },
}
