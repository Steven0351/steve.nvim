return {
  {
    'nui.nvim',
    for_cat = 'ui',
    dep_of = { 'noice.nvim', 'xcodebuild.nvim' },
  },
  {
    'img-clip.nvim',
    after = function(_)
      require('img-clip').setup {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      }
    end,
  },
}
