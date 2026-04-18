vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-web-devicons").setup({
  default = true,
})

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("Change Root To Node"))
  vim.keymap.set("n", "yy", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "yp", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "yP", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  update_focused_file = {
    enable = true,
  },
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
