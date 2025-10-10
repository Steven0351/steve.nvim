-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.exrc = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.o.relativenumber = true

vim.o.winborder = 'rounded'

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

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

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
kset { '<Esc>', '<cmd>nohlsearch<CR>' }

-- Diagnostic keymaps
kset { '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list' }

kset { '<C-h>', '<C-w><C-h>', 'Move focus to the left window' }
kset { '<C-l>', '<C-w><C-l>', 'Move focus to the right window' }
kset { '<C-j>', '<C-w><C-j>', 'Move focus to the lower window' }
kset { '<C-k>', '<C-w><C-k>', 'Move focus to the upper window' }

kset { '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', mode = 't' }

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'

local lze = require 'lze'
lze.register_handlers(require('lzutils').for_cat)
local plugins = require 'plugins'
lze.load(plugins)

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

-- vim: ts=2 sts=2 sw=2 et
