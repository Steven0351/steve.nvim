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
      end, { desc = 'Find Files (Frecency)' })

      vim.keymap.set('n', '<leader>ff', function()
        require('fzf-lua-frecency').frecency {
          cwd_only = true,
        }
      end, { desc = 'Files (Frecency)' })

      vim.keymap.set('n', '<leader>p', function()
        FzfLua.global()
      end, { desc = 'Open Palette' })

      vim.keymap.set('n', '<leader>,', function()
        FzfLua.buffers()
      end, { desc = 'Buffers' })

      vim.keymap.set('n', '<leader>fb', function()
        FzfLua.buffers()
      end, { desc = 'Buffers' })

      vim.keymap.set('n', '<leader>/', function()
        FzfLua.live_grep()
      end, { desc = 'Live Grep' })

      vim.keymap.set('n', '<leader>fg', function()
        FzfLua.live_grep()
      end, { desc = 'Live Grep' })

      vim.keymap.set('n', '<leader>fm', function()
        FzfLua.marks()
      end, { desc = 'Marks' })

      vim.keymap.set('n', '<leader>fB', function()
        FzfLua.builtin()
      end, { desc = 'FzfLua Builtins' })

      vim.keymap.set('n', '<leader>fr', function()
        FzfLua.resume()
      end, { desc = 'FzfLua Resume' })
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
