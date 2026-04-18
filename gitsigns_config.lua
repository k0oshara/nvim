require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function opts(desc)
      return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.next_hunk()
      end
    end, opts('Next change'))

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.prev_hunk()
      end
    end, opts('Previous change'))

    vim.keymap.set('n', '<leader>cs', gs.stage_hunk, opts('Stage hunk'))
    vim.keymap.set('n', '<leader>cr', gs.reset_hunk, opts('Reset hunk'))
    vim.keymap.set('n', '<leader>cp', gs.preview_hunk, opts('Preview hunk'))
    vim.keymap.set('n', '<leader>cb', function()
      gs.blame_line({ full = true })
    end, opts('Blame line'))
  end,
})
