-- Statusline for Neovim with jj (Jujutsu) integration

local M = {}

vim.api.nvim_set_hl(0, 'SteveNvimFileModified', {
  fg = '#d6d6d6',
  bold = true,
  italic = true,
})

local bg = '#151515'

vim.api.nvim_set_hl(0, 'SteveNvimDiffRenamed', {
  fg = '#b49273',
  bg = bg,
  bold = true,
})

vim.api.nvim_set_hl(0, 'SteveNvimDiffAdd', {
  fg = '#d6d6d6',
  bg = bg,
  bold = true,
})

vim.api.nvim_set_hl(0, 'SteveNvimDiffDelete', {
  fg = '#d7867d',
  bg = bg,
  bold = true,
})

vim.api.nvim_set_hl(0, 'SteveNvimDiffChange', {
  fg = '#d6bd87',
  bg = bg,
  bold = true,
})

local jj_cache = {
  change_id = '',
  bookmark = '',
  has_conflicts = false,
  is_jj_repo = false,
  stats = {
    added = 0,
    deleted = 0,
    modified = 0,
    renamed = 0,
  },
}

local watchers = {}

local function get_change_id()
  local handle = io.popen 'jj log -r @ --no-graph -T "change_id.shortest()" 2>/dev/null'
  if not handle then
    return ''
  end
  local result = handle:read('*a'):gsub('%s+$', '')
  handle:close()
  return result ~= '' and result or ''
end

local function get_closest_bookmark()
  local handle = io.popen 'jj log -r "heads(::@ & bookmarks())" --no-graph -T "bookmarks.map(|b| b.name()).join(\\" \\")" --limit 1 2>/dev/null'
  if not handle then
    return ''
  end
  local result = handle:read('*a'):gsub('%s+$', '')
  handle:close()
  return result ~= '' and result or ''
end

local function has_conflicts()
  local handle = io.popen 'jj log -r @ --no-graph -T "if(conflict, \\"yes\\", \\"no\\")" 2>/dev/null'
  if not handle then
    return false
  end
  local result = handle:read('*a'):gsub('%s+$', '')
  handle:close()
  return result == 'yes'
end

local function get_file_stats()
  local handle = io.popen 'jj status 2>/dev/null'
  if not handle then
    return { added = 0, deleted = 0, modified = 0, renamed = 0 }
  end

  local stats = { added = 0, deleted = 0, modified = 0, renamed = 0 }
  for line in handle:lines() do
    if line:match '^A ' then
      stats.added = stats.added + 1
    elseif line:match '^D ' then
      stats.deleted = stats.deleted + 1
    elseif line:match '^M ' then
      stats.modified = stats.modified + 1
    elseif line:match '^R ' then
      stats.renamed = stats.renamed + 1
    end
  end
  handle:close()

  return stats
end

local function update_jj_cache()
  jj_cache.change_id = get_change_id()
  jj_cache.bookmark = get_closest_bookmark()
  jj_cache.has_conflicts = has_conflicts()
  jj_cache.stats = get_file_stats()
end

local function find_jj_root()
  local path = vim.fn.expand '%:p:h'
  if path == '' then
    path = vim.fn.getcwd()
  end

  while path ~= '/' and path ~= '' do
    local jj_dir = path .. '/.jj'
    if vim.fn.isdirectory(jj_dir) == 1 then
      return jj_dir
    end
    path = vim.fn.fnamemodify(path, ':h')
  end

  return nil
end

local function stop_watchers()
  for _, watcher in pairs(watchers) do
    if watcher then
      watcher:stop()
    end
  end
  watchers = {}
end

local function setup_watchers()
  stop_watchers()

  local jj_root = find_jj_root()
  if not jj_root then
    jj_cache.is_jj_repo = false
    return
  end

  jj_cache.is_jj_repo = true
  update_jj_cache()

  local watch_paths = {
    jj_root .. '/repo/op_store',
    jj_root .. '/repo/store',
  }

  for _, watch_path in ipairs(watch_paths) do
    if vim.fn.isdirectory(watch_path) == 1 then
      local watcher = vim.loop.new_fs_event()
      if watcher then
        watcher:start(
          watch_path,
          { recursive = true },
          vim.schedule_wrap(function(err, filename, events)
            if not err then
              update_jj_cache()
              vim.cmd 'redrawstatus'
            end
          end)
        )
        table.insert(watchers, watcher)
      end
    end
  end
end

-- Mode configuration
local modes = {
  n = { text = 'Normal      ', hl = 'Type' },
  i = { text = 'Insert      ', hl = 'Function' },
  v = { text = 'Visual      ', hl = 'Keyword' },
  V = { text = 'Visual-Line ', hl = 'Keyword' },
  ['\22'] = { text = 'Visual-Block', hl = 'Keyword' }, -- <C-V>
  R = { text = 'Replace     ', hl = 'Statement' },
  c = { text = 'Command     ', hl = 'String' },
  t = { text = 'Terminal    ', hl = 'Function' },
  s = { text = 'Select      ', hl = 'Keyword' },
  S = { text = 'Select-Line ', hl = 'Keyword' },
  ['\19'] = { text = 'Select-Block', hl = 'Keyword' }, -- <C-S>
}

function M.mode()
  local m = vim.fn.mode()
  local config = modes[m] or { text = m:upper(), hl = 'Normal' }
  return string.format('%%#%s# %s %%*', config.hl, config.text)
end

local bufid = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local buf = function()
  return vim.bo[bufid()]
end

local bufnr = function()
  return '#' .. bufid()
end

function M.path()
  local filename = vim.fn.expand(bufnr() .. ':t')
  if filename == '' then
    filename = '[No Name]'
  end

  local icon, hl = MiniIcons.get('file', filename)

  local modified = buf().modified and 'SteveNvimFileModified' or 'Label'
  local readonly = buf().readonly and ' ' or ''

  return string.format('%%#%s# %s%%* %%#%s#%%t%s%%*', hl, icon, modified, readonly)
end

-- jj component (bookmark + change ID + conflicts + file stats)
function M.jj()
  if not jj_cache.is_jj_repo then
    return ''
  end

  if jj_cache.bookmark == '' and jj_cache.change_id == '' then
    return ''
  end

  local parts = {}

  if jj_cache.bookmark ~= '' then
    table.insert(parts, string.format('%%#Function#󰂺 %s', jj_cache.bookmark))
  end

  local change_hl = jj_cache.has_conflicts and 'DiagnosticError' or 'Comment'

  if jj_cache.change_id ~= '' then
    table.insert(parts, string.format('%%#%s#@%s', change_hl, jj_cache.change_id))
  end

  -- Add file statistics if there are any changes
  local stats_parts = {}
  if jj_cache.stats.added > 0 then
    table.insert(stats_parts, string.format('%%#SteveNvimDiffAdd# %d', jj_cache.stats.added))
  end

  if jj_cache.stats.modified > 0 then
    table.insert(stats_parts, string.format('%%#SteveNvimDiffChange# %d', jj_cache.stats.modified))
  end

  if jj_cache.stats.deleted > 0 then
    table.insert(stats_parts, string.format('%%#SteveNvimDiffDelete# %d', jj_cache.stats.deleted))
  end

  if jj_cache.stats.renamed > 0 then
    table.insert(stats_parts, string.format('%%#SteveNvimDiffRenamed# %d', jj_cache.stats.renamed))
  end

  if #stats_parts > 0 then
    table.insert(parts, table.concat(stats_parts, ' '))
  end

  return table.concat(parts, ' ')
end

function M.diagnostics()
  local result = {}
  local diagnostics = vim.diagnostic.get(bufid())
  local counts = { error = 0, warn = 0, info = 0, hint = 0 }

  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      counts.error = counts.error + 1
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
      counts.warn = counts.warn + 1
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
      counts.info = counts.info + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      counts.hint = counts.hint + 1
    end
  end

  if counts.error > 0 then
    table.insert(result, string.format('%%#DiagnosticError# %d', counts.error))
  end
  if counts.warn > 0 then
    table.insert(result, string.format('%%#DiagnosticWarn# %d', counts.warn))
  end
  if counts.hint > 0 then
    table.insert(result, string.format('%%#DiagnosticHint# %d', counts.hint))
  end
  if counts.info > 0 then
    table.insert(result, string.format('%%#DiagnosticInfo# %d', counts.info))
  end

  return #result > 0 and table.concat(result, ' ') or ''
end

function M.progress()
  local line = vim.fn.line('.', vim.g.statusline_winid)
  local total = vim.fn.line('$', vim.g.statusline_winid)
  local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
  local line_ratio = line / total
  local index = math.ceil(line_ratio * #chars)

  return string.format('%%#Number#%%5l:%%-3v %%#Function#%s', chars[index])
end

function M.build_statusline()
  local width = vim.api.nvim_win_get_width(0)

  local left = {
    M.mode(),
  }

  local left_middle = {
    M.path(),
  }

  if width >= 95 then
    table.insert(left_middle, M.diagnostics())
  end

  local right_middle = {
    M.jj(),
  }

  local right = {
    M.progress(),
  }

  return table.concat(left, ' ') .. '%=' .. table.concat(left_middle, '  ') .. '%=' .. table.concat(right_middle, '  ') .. '%=' .. table.concat(right, ' ')
end

function M.setup()
  setup_watchers()

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'DirChanged' }, {
    callback = function()
      setup_watchers() -- Re-setup watchers when changing buffers/dirs
      vim.opt.statusline = '%!v:lua.require("statusline").build_statusline()'
    end,
  })

  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      stop_watchers()
    end,
  })

  vim.opt.statusline = '%v:lua.require("statusline").build_statusline()'
end

-- Expose setup_watchers for manual refresh if needed
M.refresh = setup_watchers

return M
