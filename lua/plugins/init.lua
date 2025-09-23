return {
  {
    'oil.nvim',
    after = function(_)
      local oil = require 'oil'

      oil.setup {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ['q'] = 'actions.close',
        },
      }

      vim.keymap.set('n', '<leader>o', function()
        oil.toggle_float(nil)
      end, { desc = 'Open oil' })
    end,
  },
  { import = 'plugins.mini' },
  { import = 'plugins.nvchad' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.noice' },
  { import = 'plugins.snacks' },
  { import = 'plugins.fzf' },
  { import = 'plugins.shared' },
  { import = 'plugins.sleuth' },
  { import = 'plugins.lazydev' },
  { import = 'plugins.lsp' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.markdown' },
  { import = 'plugins.jj' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.formatting' },
  { import = 'plugins.ai' },
  { import = 'plugins.debug' },
  { import = 'plugins.xcodebuild' },
  { import = 'plugins.grug-far' },
}
