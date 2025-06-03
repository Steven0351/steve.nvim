return {
  {
    'olimorris/codecompanion.nvim',
    opts = {
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = 'cmd:op read "op://private/Anthropic API Key/notesPlain" --no-newline',
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'anthropic',
          tools = {
            -- vectorcode = {
            --   description = 'Use VectorCode to retrieve project context',
            --   callback = require('vectorcode.integrations').codecompanion.chat.maketool(),
            -- },
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'Davidyz/VectorCode',
        opt = {},
      },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      providers = {
        claude = {
          model = 'claude-3-7-sonnet-20250219',
        },
      },
      file_selector = {
        provider = 'snacks',
      },
      selector = {
        provider = 'snacks',
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.icons',
      'MeanderingProgrammer/render-markdown.nvim',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
    },
  },
}
