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
Plug 'windwp/nvim-autopairs'
Plug 'rust-lang/rust.vim'

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

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')


npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false }}

remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

_G.MUtils= {}

MUtils.CR = function()
                                if vim.fn.pumvisible() ~= 0 then
                                                                if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                                                                                                return npairs.esc('<c-y>')
                                                                else
                                                                                                return npairs.esc('<c-e>') .. npairs.autopairs_cr()
                                                                end
                                else
                                                                return npairs.autopairs_cr()
                                end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
                                if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
                                                                return npairs.esc('<c-e>') .. npairs.autopairs_bs()
                                else
                                                                return npairs.autopairs_bs()
                                end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

EOF

colorscheme catppuccin

let g:python3_host_prog = '/usr/bin/python3'

set relativenumber
set splitright
set ts=2
