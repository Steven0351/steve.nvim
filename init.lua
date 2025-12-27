vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.exrc = true

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.winborder = 'solid'

vim.opt.mouse = 'a'

vim.opt.showmode = false

-- TODO: Make this work in WSL on windows at some point
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'
vim.opt.cursorline = true

vim.opt.scrolloff = 20

vim.opt.confirm = true

if nixCats 'next' then
  vim.opt.cmdheight = 0
  require('vim._extui').enable {
    msg = {
      target = 'msg',
    },
  }
end

---@alias mode 'n' | 'i' | 'v' | 'x' | 's' | 'o' | 'c' | 't' | mode[]

---@class kset.Opts
---@field [1] string lhs
---@field [2] function | string rhs
---@field [3] string? desc
---@field mode mode?
---@field opts vim.keymap.set.Opts?

---vim.keymap.set helper that opts for defaulting to the most common case
---of normal mode and the only value of opts being the description
---@param opts kset.Opts
_G.kset = function(opts)
  local lhs = opts[1]
  local rhs = opts[2]
  local mode = opts.mode or 'n'
  local _opts = opts.opts or {}
  _opts.desc = opts[3] or _opts.desc

  vim.keymap.set(mode, lhs, rhs, _opts)
end

kset { '<Esc>', '<cmd>nohlsearch<CR>' }

-- Diagnostic keymaps
kset { '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list' }

kset { '<C-h>', '<C-w><C-h>', 'Move focus to the left window' }
kset { '<C-l>', '<C-w><C-l>', 'Move focus to the right window' }
kset { '<C-j>', '<C-w><C-j>', 'Move focus to the lower window' }
kset { '<C-k>', '<C-w><C-k>', 'Move focus to the upper window' }

kset { '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', mode = 't' }

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lze = require 'lze'
lze.register_handlers(require('lzutils').for_cat)
local plugins = require 'plugins'
lze.load(plugins)

local status = require 'statusline'
status.setup()

-- vim: ts=2 sts=2 sw=2 et
