return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'rmehri01/onenord.nvim',
    enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'onenord'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      local colors = require('onenord.colors').load()

      require('onenord').setup {
        custom_highlights = {
          MiniIconsGrey = { fg = colors.fg },
          MiniIconsPurple = { fg = colors.purple },
          MiniIconsBlue = { fg = colors.dark_blue },
          MiniIconsAzure = { fg = colors.blue },
          MiniIconsCyan = { fg = colors.cyan },
          MiniIconsGreen = { fg = colors.green },
          MiniIconsYellow = { fg = colors.yellow },
          MiniIconsOrange = { fg = colors.orange },
          MiniIconsRed = { fg = colors.red },
        },
      }
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    enabled = false,
    init = function()
      vim.cmd.colorscheme 'nordfox'
    end,
  },
}
