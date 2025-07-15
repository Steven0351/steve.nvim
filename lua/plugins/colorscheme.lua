return {
  {
    'webhooked/kanso.nvim',
    lazy = false,
    enabled = true,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'kanso-zen'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    enabled = true,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = '#C0A36E' },
          BlinkCmpMenuBorder = { fg = '', bg = '' },

          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          -- LineNr = { fg = "#C0A36E", bg = "NONE" },
          CursorLineNr = { fg = colors.palette.sakuraPink, bg = 'NONE' },
        }
      end,
    },
    init = function()
      vim.cmd.colorscheme 'kanagawa-wave'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    enabled = false,
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
