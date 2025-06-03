return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
      'stevearc/oil.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>X', '<cmd>XcodebuildPicker<cr>', mode = 'n', desc = 'Show Xcodebuild Actions' },
      { '<leader>xb', '<cmd>XcodebuildBuild<cr>', mode = 'n', desc = 'Build Projiect' },
      { '<leader>xr', '<cmd>XcodebuildBuild<cr>', mode = 'n', desc = 'Build & Run Project' },
      { '<leader>xt', '<cmd>XcodebuildTest<cr>', mode = 'n', desc = 'Run Tests' },
      { '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', mode = 'v', desc = 'Run Selected Tests' },
      { '<leader>xT', '<cmd>XcodebuildTestClass<cr>', mode = 'n', desc = 'Run Current Test Class' },
      { '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', mode = 'n', desc = 'Repeat Last Test Run' },
      { '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', mode = 'n', desc = 'Toggle Xcodebuild Logs' },
      { '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', mode = 'n', desc = 'Toggle Code Coverage' },
      { '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', mode = 'n', desc = 'Toggle Test Explorer' },
      { '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', mode = 'n', desc = 'Show Code Actions' },
    },
    opts = {
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
    },
  },
}
