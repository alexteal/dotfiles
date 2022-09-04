vim.g.python_host_prog = os.getenv('NEOVIM_PY_PATH')
--Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if os.getenv('TMUX') then
    if vim.fn.has('nvim') then
        vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = '1'
    end
end

if vim.fn.has('termguicolors') then
    vim.opt.termguicolors = true
end
require('packer').startup(function()
    use 'wbthomason/packer.nvim' 
    -- colorschemes
    use { 'dracula/vim' }
    use { 'morhetz/gruvbox' }
    use { 'NLKNguyen/papercolor-theme' }
    -- transparent bg
    use { 'xiyaowong/nvim-transparent' }
    -- IDE style things
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', cmd="make"}
    use { 'junegunn/fzf', run = './install --bin'}
    use { 'kyazdani42/nvim-web-devicons', disable = false }
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }
    use { 'romgrk/barbar.nvim', disable = true }
    use { 'scrooloose/nerdtree' , requires = {'ryanoasis/vim-devicons', 'Xuyuanp/nerdtree-git-plugin'}, disable = true }
    -- snippets
    use { 'honza/vim-snippets', requires = 'SirVer/ultisnips' } 
    -- deoplete completions
    use { 'Shougo/deoplete.nvim'}
    use { 'zchee/deoplete-jedi'}
    use { 'dense-analysis/ale' , disable = false}
    use { 'prabirshrestha/vim-lsp' , disable = false }
    use { 'lighttiger2505/deoplete-vim-lsp' , disable = false }
    use { 'alvan/vim-closetag' }
    use { 'LionC/nest.nvim' }
    use { 'rafcamlet/nvim-luapad', requires = "antoinemadec/FixCursorHold.nvim" }
    -- ESLinter for webdev
    use { 'neovim/nvim-lspconfig', disable = false}
    use { 'jose-elias-alvarez/null-ls.nvim', disable = false }
    use { 'MunifTanjim/eslint.nvim' , disable =false  }
    -- Prettier Async, also for webdev
    use { 'prettier/vim-prettier', 
    run = 'yarn install --frozen-lockfile --production',
    ft={'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx', 'jsx', 'typescriptreact'}, disable = false }
    use { 'tjdevries/nlua.nvim' }
    use { 'euclidianAce/BetterLua.vim' }
    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
    use { 'numirias/semshi', run = ":UpdateRemotePlugins" }
    use { 'lervag/vimtex' }
    -- random tools
    use { 'vimwiki/vimwiki' }
    use { 'ryanoasis/vim-devicons', disable = true }
    use { 'lambdalisue/suda.vim' } -- write to sudo with SudaWrite
    use { 'jamessan/vim-gnupg' }
end)

--ultisnips expansion with enter
--vim.g.UltiSnipsExpandTrigger='<CR>'

vim.api.nvim_create_autocmd("InsertEnter", {
    command = "call deoplete#enable()"
})

-- these prevent first time install
require 'keymap'
require 'opts'


vim.g.closetag_filenames='*.html,*.xhtml,*.phtml,*.vue,*.tsx'

require 'nvim-tree-config'
require 'transparent-bg'

require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'nvim-web-devicons'.setup{}
require'lspconfig'.tsserver.setup{}

-- TODO convert to lua
local cmd = vim.api.nvim_command
cmd("colorscheme PaperColor")
-- spellcheck when in latex or in vimwiki
cmd("autocmd BufEnter,WinEnter,FocusGained *.tex set spelllang=en_gb spell")
-- close nvim-tree
cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
--close telescope 
cmd("autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif")
-- close nerdtree automatically
cmd("autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
cmd[[
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif 
autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif ]]
-- may not need this command, consider removing
cmd[[
command! -bang -nargs=* PRg
\ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': expand('%:p:h')}, <bang>0) ]]

cmd[[
let g:prettier#quickfix_enabled = 0
let g:prettier#exec_cmd_async = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
]]
-- for dracula theme
--cmd('hi StatusLine guibg=#424450')
--cmd('highlight ColorColumn guibg=#424450') -- dracula dark grey
--cmd('highlight ColorColumn guibg=#678686') -- same as status bar
cmd('highlight ColorColumn guibg=#89748a') -- pink
cmd[[
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
]]
