return {
  ---@module "snacks"
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = {
        enabled = true,
      },
      image = {
        enabled = true,
      },
      indent = {
        enabled = true,
      },
      input = {
        enabled = true,
      },
      notifier = {
        enabled = true,
      },
      picker = {
        enabled = true,
      },
      rename = {
        enabled = true,
      },
      statuscolumn = {
        enabled = true,
      },
      terminal = {
        enabled = true,
      },
      words = {
        enabled = true,
      },
    },
    keys = {
      {
        '<leader><space>',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find files',
      },
      {
        '<leader>,',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>e',
        function()
          Snacks.explorer()
        end,
        desc = 'File explorer',
      },
      -- find
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Find Buffers',
      },
      {
        '<leader>fm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Find marks',
      },
      {
        '<leader>tt',
        function()
          Snacks.terminal.toggle()
        end,
        desc = 'Toggle Terminal',
      },
    },
  },
}
