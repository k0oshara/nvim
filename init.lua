local vim = vim
local Plug = vim.fn['plug#']

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.maximizer_set_default_mapping = 0

vim.call('plug#begin')

Plug('sainnhe/gruvbox-material')

Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')
Plug('romgrk/barbar.nvim')
Plug('nvim-lualine/lualine.nvim') 
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('neovim/nvim-lspconfig') 

Plug('hrsh7th/cmp-buffer') 
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline') 
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp' ) 
Plug('hrsh7th/cmp-nvim-lsp-signature-help') 

Plug('ibhagwan/fzf-lua', {['branch'] = 'main'})

Plug('rmagatti/auto-session')
Plug('numToStr/Comment.nvim')
Plug('szw/vim-maximizer')
Plug('lewis6991/gitsigns.nvim')

vim.call('plug#end')

local home = os.getenv("HOME")
package.path = home .. "/.config/nvim/?.lua;" .. package.path

require "common"
require "theme"
require "vimtree"
require "barbar_config"
require "lua_line"
require "lsp"
require "cmp"
require "treesitter"
require "fzf_config"
require "lazygit"
require "autosession"
require "comment_config"
require "gitsigns_config"
-- require "trouble_config"
