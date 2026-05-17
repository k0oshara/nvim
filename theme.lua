vim.o.background = "dark"
vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_foreground = "mix"
-- vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_better_performance = 1
vim.cmd.colorscheme("gruvbox-material")

local bg = "#1b1b1b"
-- local bg = "#181818"
-- local bg = "#161616"
-- local bg = "#202020"
vim.api.nvim_set_hl(0, "Normal", { bg = bg })
vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = bg })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
