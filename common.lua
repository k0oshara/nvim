-- отобразить номера строк
vim.opt.number = true
-- включить управление мышью
vim.opt.mouse = 'a'
vim.opt.encoding="utf-8"
vim.opt.termguicolors = true
-- выключаем своп файла
vim.opt.swapfile = false
vim.opt.guicursor = "n-c:block,v:hor20,i-ci-ve:ver25,r-cr:hor20,o:block"

-- устанавливаем настройки табуляции и отступов
vim.opt.scrolloff = 7
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.winminheight = 0
vim.opt.winminwidth = 0
vim.opt.clipboard = "unnamedplus"

vim.opt.fileformat = "unix"

vim.keymap.set({ 'n', 'v' }, 'gh', '0', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'ge', 'G', { noremap = true, silent = true })
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true })

vim.keymap.set('x', 'p', '"_d"+P', { noremap = true, silent = true })
vim.keymap.set('x', 'P', '"_d"+P', { noremap = true, silent = true })

vim.keymap.set({ 'n', 'x' }, 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'X', '"_X', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 's', '"_s', { noremap = true, silent = true })
vim.keymap.set('n', 'S', '"_S', { noremap = true, silent = true })

local function swap_window_buffers(direction)
  local current_win = vim.api.nvim_get_current_win()
  local target_win = vim.fn.win_getid(vim.fn.winnr(direction))

  if target_win == 0 or target_win == current_win then
    return
  end

  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local target_buf = vim.api.nvim_win_get_buf(target_win)

  vim.api.nvim_win_set_buf(current_win, target_buf)
  vim.api.nvim_win_set_buf(target_win, current_buf)
  vim.api.nvim_set_current_win(target_win)
end

local last_window = nil
local last_direction = nil
local opposite_direction = {
  h = 'l',
  l = 'h',
  j = 'k',
  k = 'j',
}

local function focus_window(direction)
  local current_win = vim.api.nvim_get_current_win()

  if last_window
    and vim.api.nvim_win_is_valid(last_window)
    and last_window ~= current_win
    and last_direction == opposite_direction[direction]
  then
    vim.api.nvim_set_current_win(last_window)
    last_window = current_win
    last_direction = direction
    return
  end

  vim.cmd('wincmd ' .. direction)

  local target_win = vim.api.nvim_get_current_win()
  if target_win ~= current_win then
    last_window = current_win
    last_direction = direction
  end
end

vim.keymap.set('n', '<leader>ws', '<C-w>s', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wz', '<Cmd>MaximizerToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wh', function() focus_window('h') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wl', function() focus_window('l') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wj', function() focus_window('j') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wk', function() focus_window('k') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wH', function() swap_window_buffers('h') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wL', function() swap_window_buffers('l') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wJ', function() swap_window_buffers('j') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wK', function() swap_window_buffers('k') end, { noremap = true, silent = true })
