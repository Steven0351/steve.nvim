return {
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'echasnovsi/mini.icons' },
    opts = {
      options = {
        component_separators = '', --{ left = '', right = '' },
        section_separators = {
          left = '',
          right = '',
        },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
          },
          'diagnostics',
        },
        lualine_x = {
          {
            'filetype',
            icon_only = true,
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', separator = { right = '' } } },
      },
    },
  },
}
