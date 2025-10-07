return {
  {
    'codecompanion',
    for_cat = 'ai',
    event = 'DeferredUIEnter',
    after = function(_)
      local anthropic = function(adapter, key_name)
        return function()
          return require('codecompanion.adapters').extend(adapter, {
            env = {
              [key_name] = 'cmd:op read "op://private/Anthropic/credential" --no-newline',
            },
          })
        end
      end
      require('codecompanion').setup {
        adapters = {
          http = {
            anthropic = anthropic('anthropic', 'api_key'),
          },
          acp = {
            claude_code = anthropic('claude_code', 'ANTHROPIC_API_KEY'),
          },
        },
        strategies = {
          chat = {
            opts = {
              completion_provider = 'blink',
            },
            slash_commands = {
              opts = {
                provider = 'fzf_lua',
              },
            },
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
}
