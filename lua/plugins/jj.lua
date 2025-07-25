return {
  'rafikdraoui/jj-diffconflicts',
  {
    'avm99963/vim-jjdescription',
    lazy = false,
  },
  {
    'julienvincent/hunk.nvim',
    cmd = { 'DiffEditor' },
    config = function()
      require('hunk').setup {
        keys = {
          global = {
            quit = { 'q' },
            accept = { '<leader><Cr>' },
            focus_tree = { '<leader>e' },
          },

          tree = {
            expand_node = { 'l', '<Right>' },
            collapse_node = { 'h', '<Left>' },

            open_file = { '<Cr>' },

            toggle_file = { 'a' },
          },

          diff = {
            toggle_hunk = { 'A' },
            toggle_line = { 'a' },
            -- This is like toggle_line but it will also toggle the line on the other
            -- 'side' of the diff.
            toggle_line_pair = { 's' },

            prev_hunk = { '[h' },
            next_hunk = { ']h' },

            -- Jump between the left and right diff view
            toggle_focus = { '<Tab>' },
          },
        },

        ui = {
          tree = {
            -- Mode can either be `nested` or `flat`
            mode = 'nested',
            width = 35,
          },
          --- Can be either `vertical` or `horizontal`
          layout = 'vertical',
        },

        icons = {
          selected = '󰡖',
          deselected = '',
          partially_selected = '󰛲',

          folder_open = '',
          folder_closed = '',
        },
      }
    end,
  },
}
