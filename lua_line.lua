local function maximizer_status()
  return vim.t.maximizer_sizes and 'Z' or ' '
end

local function total_lines()
  return tostring(vim.api.nvim_buf_line_count(0))
end

require('lualine').setup ({
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode', maximizer_status},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {total_lines},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})
