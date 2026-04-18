-- Use vim.keymap.set instead of vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local function fzf(name)
  return function()
    require("fzf-lua")[name]()
  end
end

-- Map <leader>f to fzf-lua's file search
keymap("n", "<leader>f", fzf("files"), { desc = "Fzf files" })

-- Map <leader>g to fzf-lua's live grep
keymap("n", "<leader>g", fzf("live_grep"), { desc = "Fzf live grep" })
