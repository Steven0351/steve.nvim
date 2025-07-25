return {
  'obsidian-nvim/obsidian.nvim',
  verion = '*',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/.local/share/obsidian/**/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/.local/share/obsidian/**/*.md',
  },
  opts = {
    workspaces = {
      {
        name = 'nexus',
        path = '~/.local/share/obsidian/nexus',
      },
      {
        name = 'notes',
        path = '~/.local/share/obsidian/notes',
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    picker = {
      name = 'snacks.pick',
    },
  },
}
