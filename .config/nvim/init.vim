" Plugin management
call plug#begin('~/.nvim/plugged')

Plug 'catppuccin/nvim', {'branch': 'main', 'as': 'catppuccin'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

call plug#end()

" Global variables
let g:coq_settings = {'auto_start': 'shut-up' }
let g:python3_host_prog = '/usr/bin/python3'

" Indent behaviour
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

" For nvim-tree
set splitright

lua << EOF
-- Key remappings
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true}) -- Ctrl + Backspace

-- Import plugins
local catppuccin = require('catppuccin')
local lsp = require('lspconfig')
local coq = require('coq')
local treesitter = require('nvim-treesitter.configs')
local nvimtree = require('nvim-tree')
local lualine = require('lualine')

-- Setup the colorscheme
catppuccin.setup()

-- Lualine setup
lualine.setup()

-- nvim-tree setup
nvimtree.setup {
	view = {
		side = "left",
		width = 25,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
}

-- Setup LSP for coq
lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())

-- Setup for treesitter
treesitter.setup {
	ensure_installed = { "c", "cpp", "python", "rust", "cmake" },

	sync_install = false,

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
}
EOF

colorscheme catppuccin
