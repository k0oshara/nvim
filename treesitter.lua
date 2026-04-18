require('nvim-treesitter.config').setup {
  ensure_installed = { "lua", "vim", "vimdoc", "bash", "json", "go", "asm", "python", "zig", "c", "cpp" },
  highlight = { enable = true },
  incremental_selection = { enable = true },
}
