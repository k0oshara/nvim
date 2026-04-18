require('barbar').setup {
	animation = false,
	clickable = true,
	exclude_ft = {'javascript'},
	exclude_name = {'package.json'},
	focus_on_close = 'left',
	highlight_inactive_file_icons = false,
	highlight_visible = true,
	icons = {
		buffer_index = false,
		buffer_number = false,
		button = 'x',
		diagnostics = {
		  [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'E'},
		  [vim.diagnostic.severity.WARN] = {enabled = false},
		  [vim.diagnostic.severity.INFO] = {enabled = false},
		  [vim.diagnostic.severity.HINT] = {enabled = true},
		},
		gitsigns = {
		  added = {enabled = true, icon = '+'},
		  changed = {enabled = true, icon = '~'},
		  deleted = {enabled = true, icon = '-'},
		},
		filetype = {
		  custom_colors = false,
		  enabled = false,
		},
		separator = {left = '|', right = ''},
		separator_at_end = true,
		modified = {button = '*'},
		pinned = {button = 'P', filename = true},
		preset = 'default',
		alternate = {filetype = {enabled = false}},
		current = {buffer_index = true},
		inactive = {button = 'x'},
		visible = {modified = {buffer_number = false}},
	},
	insert_at_end = true,
	maximum_padding = 1,
	minimum_padding = 1,
	maximum_length = 30,
	minimum_length = 0,
	semantic_letters = true,
	sidebar_filetypes = {
		NvimTree = true,
		undotree = {text = 'undotree'},
		['neo-tree'] = {event = 'BufWipeout'},
		Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
	},
	letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
	no_name_title = nil,
}

vim.keymap.set('n', 'H', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'L', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '<Cmd>BufferPin<CR>', { noremap = true, silent = true })

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<Cmd>BufferGoto ' .. i .. '<CR>', { noremap = true, silent = true })
end
