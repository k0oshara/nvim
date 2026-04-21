local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>x', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

vim.diagnostic.config({
  virtual_text = false,
})

vim.filetype.add({
  extension = {
    asm = 'asm',
    nasm = 'asm',
    inc = 'asm',
  },
})

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  vim.api.nvim_buf_create_user_command(bufnr, 'Fmt', function()
    vim.lsp.buf.format({ async = true })
  end, { desc = 'Format current buffer' })

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = true,
}

local common_config = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

local servers = {
  gopls = {},
  clangd = {},
  asm_lsp = {},
  pyright = {},
  bashls = {},
  zls = {},
}

local server_names = vim.tbl_keys(servers)
table.sort(server_names)

local function complete_server_names(_, _, _)
  return server_names
end

local function get_buf_clients(name)
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if not name or name == '' then
    return clients
  end

  return vim.tbl_filter(function(client)
    return client.name == name
  end, clients)
end

local function setup_server(name, config)
  if vim.lsp.config then
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
    return
  end

  require('lspconfig')[name].setup(config)
end

for name, config in pairs(servers) do
  setup_server(name, vim.tbl_deep_extend('force', common_config, config))
end

vim.api.nvim_create_user_command('LspStop', function(cmdopts)
  local clients = get_buf_clients(cmdopts.args)
  if vim.tbl_isempty(clients) then
    vim.notify('No matching LSP clients for current buffer', vim.log.levels.INFO)
    return
  end

  for _, client in ipairs(clients) do
    if client.stop then
      client:stop()
    end
  end
end, {
  nargs = '?',
  complete = complete_server_names,
  desc = 'Stop LSP clients for current buffer',
})

vim.api.nvim_create_user_command('LspStart', function(cmdopts)
  local bufnr = vim.api.nvim_get_current_buf()
  local targets = cmdopts.args ~= '' and { cmdopts.args } or server_names

  if vim.lsp.config then
    vim.lsp.enable(targets)
    return
  end

  local lspconfig = require('lspconfig')
  for _, name in ipairs(targets) do
    local config = lspconfig[name]
    if config and config.manager then
      config.manager.try_add_wrapper(bufnr)
    end
  end
end, {
  nargs = '?',
  complete = complete_server_names,
  desc = 'Start LSP clients for current buffer',
})

vim.api.nvim_create_user_command('LspInfo', function()
  local lines = {
    'Buffer: ' .. vim.api.nvim_get_current_buf(),
    'Filetype: ' .. vim.bo.filetype,
    'Active clients:',
  }

  local clients = get_buf_clients()
  if vim.tbl_isempty(clients) then
    table.insert(lines, '  (none)')
  else
    for _, client in ipairs(clients) do
      table.insert(lines, ('  - %s (id=%d)'):format(client.name, client.id))
    end
  end

  table.insert(lines, 'Configured servers: ' .. table.concat(server_names, ', '))
  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO, { title = 'LSP Info' })
end, {
  desc = 'Show LSP info for current buffer',
})
