vim.o.background = "dark"
-- vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_foreground = "material"
-- vim.cmd.colorscheme("gruvbox-material")

require("tokyonight").setup({
  style = "night",
  terminal_colors = true,
})

vim.cmd.colorscheme("tokyonight-night")
