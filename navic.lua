local M = {}

local function clean_name(name)
  if not name or name == "" then
    return ""
  end

  return name:gsub("%b()", ""):gsub("%s+$", "")
end

function M.get_winbar()
  local ok, navic = pcall(require, "nvim-navic")
  if not ok then
    return ""
  end

  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype ~= "" then
    return ""
  end

  if not navic.is_available(bufnr) then
    return ""
  end

  local data = navic.get_data(bufnr) or {}
  local names = {}
  for _, item in ipairs(data) do
    local name = clean_name(item.name)
    if name ~= "" then
      table.insert(names, name)
    end
  end

  return table.concat(names, " > ")
end

function M.attach(client, bufnr)
  local ok, navic = pcall(require, "nvim-navic")
  if not ok or not client.server_capabilities.documentSymbolProvider then
    return
  end

  navic.attach(client, bufnr)
end

local ok, navic = pcall(require, "nvim-navic")
if ok then
  navic.setup({
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    safe_output = true,
    icons = {},
  })
end

vim.o.winbar = "%!v:lua.require'navic'.get_winbar()"
vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
vim.api.nvim_set_hl(0, "WinBarNC", { link = "NormalNC" })

return M
