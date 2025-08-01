return {
  {
    'luvit-meta',
    for_cat = 'neodev',
    dep_of = 'lazydev.nvim',
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'lazydev.nvim',
    for_cat = 'neodev',
    dep_of = 'blink.cmp',
    ft = 'lua',
    after = function(_)
      require('lazydev').setup {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      }
    end,
  },
}
