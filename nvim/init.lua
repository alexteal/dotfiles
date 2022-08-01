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
    use 'dracula/vim' 
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', cmd="make"}
    use { 'junegunn/fzf', run = './install --bin'}
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'romgrk/barbar.nvim', disable = true }
    use { 'scrooloose/nerdtree' }
    use { 'vimwiki/vimwiki' }
    use { 'numirias/semshi', run = ":UpdateRemotePlugins" }
    -- snippets
    use { 'honza/vim-snippets', requires = 'SirVer/ultisnips' } 
    -- deoplete completions
    use { 'Shougo/deoplete.nvim' }
    use { 'zchee/deoplete-jedi' }
    use { 'prabirshrestha/vim-lsp' }
    use { 'lighttiger2505/deoplete-vim-lsp' }
    use { 'alvan/vim-closetag' }
    use { 'LionC/nest.nvim' }
    use { 'rafcamlet/nvim-luapad', requires = "antoinemadec/FixCursorHold.nvim" }
    -- ESLinter for webdev
    use { 'neovim/nvim-lspconfig' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 'MunifTanjim/eslint.nvim' }
    -- Prettier Async, also for webdev
    use { 'prettier/vim-prettier', 
        run = 'yarn install --frozen-lockfile --production',
        ft={'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx', 'jsx', 'typescriptreact'}}
    use { 'tjdevries/nlua.nvim' }
    use { 'euclidianAce/BetterLua.vim' }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
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

require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}

-- TODO convert to lua
local cmd = vim.api.nvim_command
cmd("colorscheme dracula")
cmd("autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif")
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

cmd('hi StatusLine guibg=#424450')
