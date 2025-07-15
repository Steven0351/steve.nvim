---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/oil.nvim',
    lazy = true,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['q'] = 'actions.close',
      },
    },
    keys = {
      {
        '<leader>o',
        function()
          require('oil').toggle_float(nil)
        end,
        desc = 'Open oil',
      },
    },
  },
}
