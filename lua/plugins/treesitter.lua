return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter',
    event = 'DeferredUIEnter',
    dep_of = { 'nvim-treesitter-textobjects', 'kulala.nvim' },
    for_cat = 'treesitter',
    after = function(_)
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      }
    end,
  },
}
