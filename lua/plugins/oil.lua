local win = nil
local open_oil = function(split)
  local height = math.floor(vim.api.nvim_win_get_height(0) / 3)
  local win_opts = { split = split, height = height }

  if split == 'float' then
    require('oil').toggle_float(nil)
    return
  end

  if not win then
    local buf = vim.api.nvim_create_buf(false, false)
    win = vim.api.nvim_open_win(buf, true, win_opts)
    require('oil').open(nil)
    vim.api.nvim_create_autocmd('WinClosed', {
      buffer = buf,
      callback = function()
        win = nil
      end,
    })
  else
    vim.api.nvim_win_close(win, true)
    win = nil
  end
end

local oil_shortcut = function(keys, split)
  vim.keymap.set('n', '<leader>' .. keys, function()
    open_oil(split)
  end, { desc = 'Toggle oil - ' .. split })
end

oil_shortcut('oj', 'below')
oil_shortcut('ok', 'above')
oil_shortcut('oh', 'left')
oil_shortcut('ol', 'right')
oil_shortcut('of', 'float')

return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        float = {
          max_height = math.floor(vim.api.nvim_win_get_height(0) / 2),
          max_width = math.floor(vim.api.nvim_win_get_height(0) / 1.25),
        },
      }
    end,
  },
}
