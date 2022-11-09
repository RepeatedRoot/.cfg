call plug#begin('~/.nvim/plugged')

Plug 'catppuccin/nvim', {'branch': 'main', 'as': 'catppuccin'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hoob3rt/lualine.nvim'
Plug 'christoomey/vim-system-copy'

call plug#end()

lua << EOF
local catppuccin = require("catppuccin")

catppuccin.setup()

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "python", "rust" },
	
	sync_install = false,

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
}

require'nvim-tree'.setup {
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

vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

require'lualine'.setup()
EOF

colorscheme catppuccin

let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_perl_provider = 0

set splitright
