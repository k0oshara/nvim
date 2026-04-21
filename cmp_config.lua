vim.o.completeopt="menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require'cmp'
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
enabled = true,
snippet = {
  -- No snippet engine configured yet.
  expand = function(args)
    vim.snippet.expand(args.body)
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
preselect = cmp.PreselectMode.Item,
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.abort()
    else
      cmp.complete()
    end
  end, { 'i', 's' }),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<Tab>'] = cmp.mapping(function(fallback)
	  local col = vim.fn.col('.') - 1
	  if cmp.visible() then
		cmp.select_next_item(select_opts)
	  elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		fallback()
	  else
		cmp.complete()
	  end
  end, {'i', 's'}),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
	  if cmp.visible() then
		cmp.select_prev_item(select_opts)
	  else
		fallback()
	  end
  end, {'i', 's'}),
}),
completion = {
  autocomplete = { cmp.TriggerEvent.TextChanged },
  keyword_length = 1,
},
sources = cmp.config.sources({
  { name = 'nvim_lsp', keyword_length = 1 },
  { name = 'nvim_lsp_signature_help' },
}, {
  { name = 'buffer' },
}),
formatting = {
  format = function(entry, item)
    item.menu = ({
      nvim_lsp = '[LSP]',
      nvim_lsp_signature_help = '[sig]',
      buffer = '[buf]',
      path = '[path]',
      cmdline = '[cmd]',
    })[entry.source.name]
    return item
  end,
},
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

vim.api.nvim_create_user_command('CmpInfo', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local names = vim.tbl_map(function(client)
    return client.name
  end, clients)

  vim.notify(table.concat({
    'cmp visible: ' .. tostring(cmp.visible()),
    'filetype: ' .. vim.bo.filetype,
    'lsp clients: ' .. (#names > 0 and table.concat(names, ', ') or '(none)'),
  }, '\n'), vim.log.levels.INFO, { title = 'Cmp Info' })
end, { desc = 'Show cmp diagnostics for current buffer' })
