return {
  {
    'fzf-lua',
    dep_of = 'fzf-lua-frecency',
    after = function(_)
      require('fzf-lua').setup {
        fzf_colors = true,
        winopts = {
          border = 'solid',
          preview = {
            border = 'solid',
          },
        },
      }

      local frecency = function()
        require('fzf-lua-frecency').frecency {
          cwd_only = true,
        }
      end

      kset { '<leader><space>', frecency, 'Find Files (Frecency)' }
      kset { '<leader>ff', frecency, 'Find Files (Frecency)' }
      kset { '<leader>p', FzfLua.global, 'Open Palette' }
      kset { '<leader>,', FzfLua.buffers, 'Buffers' }
      kset { '<leader>fb', FzfLua.buffers, 'Buffers' }
      kset { '<leader>/', FzfLua.live_grep, 'Live Grep' }
      kset { '<leader>fg', FzfLua.live_grep, 'Live Grep' }
      kset { '<leader>fm', FzfLua.marks, 'Marks' }
      kset { '<leader>fB', FzfLua.builtin, 'FzfLua Builtins' }
      kset { '<leader>fr', FzfLua.resume, 'FzfLua Resume' }
      kset { '<leader>fs', FzfLua.lsp_workspace_symbols, 'Workspace Symbols' }
      kset { '<leader>fd', FzfLua.diagnostics_document, 'Document Diagnostics' }
      kset { '<leader>fD', FzfLua.diagnostics_workspace, 'Workspace Diagnostics' }
      kset { '<leader>fk', FzfLua.keymaps, 'Keymaps' }
      kset { '<leader>fl', FzfLua.lsp_finder, 'LSP under cursor' }
      kset { '<leader>fR', FzfLua.registers, 'Registers' }
    end,
  },
  {
    'fzf-lua-frecency',
    after = function(_)
      require('fzf-lua-frecency').setup()
    end,
  },
}
