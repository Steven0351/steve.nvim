return {
  {
    'codecompanion.nvim',
    for_cat = 'ai',
    after = function(_)
      require('codecompanion').setup {
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
      }
    end,
  },
  {
    'dressing.nvim',
    dep_of = 'avante.nvim',
    for_cat = 'ai',
  },
  {
    'img-clip.nvim',
    dep_of = 'avante.nvim',
    for_cat = 'ai',
    after = function(_)
      require('img-clip').setup {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      }
    end,
  },
  {
    'avante.nvim',
    for_cat = 'ai',
    event = 'DeferredUIEnter',
    after = function(_)
      require('avante').setup {
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
      }
    end,
  },
}
