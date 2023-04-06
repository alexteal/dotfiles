-- new colorscheme
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end
vim.g.catppuccin_flavour = "macchiato"
catppuccin.setup()
vim.cmd [[colorscheme catppuccin]]

-- luacheck: globals vim
vim.g.python3_host_prog = os.getenv('NEOVIM_PY_PATH')

--Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if os.getenv('TMUX') then
    if vim.fn.has('nvim') then
        vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = '1'
    end
end
if vim.fn.has('termguicolors') then
    vim.opt.termguicolors = true
end

require('me.path')
require('me.opts')
require('me.plugins')
require('me.plugin-opts')
require('me.keymap')
--require('me.dap')
require('me.legacy')
require('nvim-tree-config')
--require 'transparent-bg'
--require'lspconfig'.pyright.setup{}
--require'lspconfig'.bashls.setup{}
--require'lspconfig'.tsserver.setup{}
