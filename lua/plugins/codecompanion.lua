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
      local companion = require 'codecompanion'

      -- Fidget.nvim integration for activity spinner
      local fidget_handle
      local has_fidget, fidget = pcall(require, 'fidget')

      if has_fidget then
        local group = vim.api.nvim_create_augroup('CodeCompanionFidget', {})

        vim.api.nvim_create_autocmd({ 'User' }, {
          pattern = 'CodeCompanionRequestStarted',
          group = group,
          callback = function()
            if fidget_handle then
              fidget_handle.message = 'Abort.'
              fidget_handle:cancel()
            end
            fidget_handle = fidget.progress.handle.create {
              title = '',
              message = 'Thinking...',
              lsp_client = { name = 'CodeCompanion' },
            }
          end,
        })

        vim.api.nvim_create_autocmd({ 'User' }, {
          pattern = 'CodeCompanionRequestFinished',
          group = group,
          callback = function()
            if fidget_handle then
              fidget_handle.message = 'Done.'
              fidget_handle:finish()
              fidget_handle = nil
            end
          end,
        })
      end

      companion.setup {
        display = {
          action_palette = {
            provider = 'fzf_lua',
          },
        },
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
            adapter = 'claude_code',
            tools = {
              -- vectorcode = {
              --   description = 'Use VectorCode to retrieve project context',
              --   callback = require('vectorcode.integrations').codecompanion.chat.maketool(),
              -- },
            },
          },
        },
      }

      kset { '<leader>cc', companion.chat, '[C]ode Companion [C]hat' }
      kset { '<leader>ct', companion.toggle, '[C]ode Companion [T]oggle' }
      kset { '<leader>ca', companion.add, '[C]ode Companion [A]dd Selection', mode = 'v' }
      kset { '<leader>cp', companion.actions, '[C]ode Companion Action [P]alette' }
    end,
  },
}
