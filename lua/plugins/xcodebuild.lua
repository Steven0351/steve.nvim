return {
  {
    'xcodebuild.nvim',
    for_cat = 'xcode',
    after = function(_)
      require('xcodebuild').setup {
        integrations = {
          pymobiledevice = {
            enabled = false,
          },
          nvim_tree = {
            enabled = false,
          },
          neo_tree = {
            enabled = false,
          },
        },
      }

      kset { '<leader>X', '<cmd>XcodebuildPicker<cr>', 'Show Xcodebuild Actions' }
      kset { '<leader>xb', '<cmd>XcodebuildBuild<cr>', 'Build Projiect' }
      kset { '<leader>xr', '<cmd>XcodebuildBuild<cr>', 'Build & Run Project' }
      kset { '<leader>xt', '<cmd>XcodebuildTest<cr>', 'Run Tests' }
      kset { mode = 'v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', 'Run Selected Tests' }
      kset { '<leader>xT', '<cmd>XcodebuildTestClass<cr>', 'Run Current Test Class' }
      kset { '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', 'Repeat Last Test Run' }
      kset { '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', 'Toggle Xcodebuild Logs' }
      kset { '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', 'Toggle Code Coverage' }
      kset { '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', 'Toggle Test Explorer' }
      kset { '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', 'Show Code Actions' }
    end,
  },
  {
    'telescope.nvim',
    for_cat = 'xcode',
    on_require = 'telescope',
  },
}
