vim.api.nvim_create_user_command('LazyGit', function()
  local width = math.floor(vim.o.columns * 0.75)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single',
  })

  vim.bo[buf].bufhidden = 'wipe'
  vim.fn.termopen('lazygit', {
    on_exit = function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.schedule(function()
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end)
      end
    end,
  })
  vim.cmd('startinsert')
end, { desc = 'Open lazygit in a floating terminal' })

vim.keymap.set('n', '<leader>G', '<Cmd>LazyGit<CR>', {
  noremap = true,
  silent = true,
  desc = 'Open lazygit',
})
