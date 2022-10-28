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
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- colorschemes
    use { 'NLKNguyen/papercolor-theme' }
    -- transparent bg
    use { 'xiyaowong/nvim-transparent', disable = false }
    -- IDE style things
    use { 'nvim-lua/plenary.nvim',
        event  = { "BufNewFile", "BufRead", "InsertEnter" } }
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            {'fannheyward/telescope-coc.nvim',
        },
        { "nvim-lua/plenary.nvim",
            event  = { "BufNewFile", "BufRead", "InsertEnter" },
        },
        { 'nvim-telescope/telescope-fzf-native.nvim',
            cmd="make",
            event  = { "BufNewFile", "BufRead", "InsertEnter" },},
        { "kdheepak/lazygit.nvim",
            event  = { "BufNewFile", "BufRead", "InsertEnter" },},
        },
        config = function()
            require("telescope").load_extension("lazygit")
            require('telescope').load_extension('coc')
            require('telescope').setup({
                extensions = {
                    coc = {
                        theme = 'ivy',
                        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
                    }
                },
            })
        end,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
})
    use { 'junegunn/fzf', run = './install --bin',
        event  = { "BufNewFile", "BufRead", "InsertEnter" }
    }
    use { 'kyazdani42/nvim-web-devicons',
        disable = false ,
        config = function() require'nvim-web-devicons'.setup{} end,
    }
    use { 'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    -- snippets
    use { 'honza/vim-snippets',
        requires = 'SirVer/ultisnips' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
    }
    -- syntax / code completion
    use { 'neoclide/coc.nvim',
        branch='release',
        disable = false ,
    }
    use { 'prabirshrestha/vim-lsp' , disable = false ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'alvan/vim-closetag',
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'LionC/nest.nvim' }
    use { 'rafcamlet/nvim-luapad', requires = "antoinemadec/FixCursorHold.nvim",
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- ESLinter for webdev
    use { 'neovim/nvim-lspconfig', disable = false,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'jose-elias-alvarez/null-ls.nvim', disable = false ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'MunifTanjim/eslint.nvim' , disable =false  ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- Java linting / completion
    use { 'hrsh7th/nvim-cmp' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'hrsh7th/cmp-nvim-lsp' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'williamboman/nvim-lsp-installer' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'puremourning/vimspector' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'mfussenegger/nvim-jdtls' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'artur-shaik/jc.nvim' ,
        config = function() require('jc').setup{} end,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- debugger
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"},
        event  = { "BufNewFile", "BufRead", "InsertEnter" }, }
    -- Prettier Async, also for webdev
    use { 'prettier/vim-prettier',
        run = 'yarn install --frozen-lockfile --production',
        ft={'javascript', 'typescript', 'css', 'less', 'scss', 'json',
        'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx','jsx',
        'typescriptreact'},
        disable = false ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'tjdevries/nlua.nvim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'euclidianAce/BetterLua.vim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'numirias/semshi', run = ":UpdateRemotePlugins" ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'lervag/vimtex' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- random tools
    use { 'vimwiki/vimwiki' ,}
    use { 'lambdalisue/suda.vim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },} -- write using sudo with SudaWrite
    use { 'jamessan/vim-gnupg' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- startup screen
    use { 'mhinz/vim-startify'}
    -- colorizer for hex
    use { 'norcalli/nvim-colorizer.lua' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
        config = function() require('colorizer').setup() end,
    }

    -- disabled packages, for testing or future reference
    -- ##################################################
    -- syntax / code completion
    use { 'lighttiger2505/deoplete-vim-lsp' , disable = true }
    use { 'dense-analysis/ale' , disable = true }
    use { 'romgrk/barbar.nvim', disable = true } -- is nice, but dead buffers stay on bar
    -- deoplete completions
    use { 'Shougo/deoplete.nvim', disable = true}
    use { 'zchee/deoplete-jedi', disable = true}
    -- file viewing
    use { 'scrooloose/nerdtree' ,
        requires = {'ryanoasis/vim-devicons', 'Xuyuanp/nerdtree-git-plugin'},
        disable = true }
    -- etc.
    use { 'ryanoasis/vim-devicons', disable = true }
    -- colorschemes
    use { 'dracula/vim', disable = true  }
    use { 'morhetz/gruvbox', disable = true }
    -- END ##############################################
end)

--ultisnips expansion with enter
-- default is tab
--vim.g.UltiSnipsExpandTrigger='<CR>'

--vim.api.nvim_create_autocmd("InsertEnter", {
--    command = "call deoplete#enable()"
--})

-- these prevent first time install
require 'keymap'
require 'opts'

vim.g.closetag_filenames='*.html,*.xhtml,*.phtml,*.vue,*.tsx'

require 'nvim-tree-config'
require 'transparent-bg'

--require'lspconfig'.pyright.setup{}
--require'lspconfig'.bashls.setup{}
--require'lspconfig'.tsserver.setup{}

--debugger setup, required for each language
local dap = require('dap')
dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
            return '/usr/bin/python'
        end;
    },
}
dap.configurations.java = {
    type = 'java';
    request = "launch";
    vmArgs = "-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=y"
}
-- TODO convert to lua
local cmd = vim.api.nvim_command
-- coclist sets cursor to invisible, but this prevents it from breaking
cmd("let g:coc_disable_transparent_cursor = 1")
-- set background and transparent color
-- autocmd fixes flicker on start
cmd("autocmd! ColorScheme * highlight Normal ctermbg=NONE guibg=NONE")
cmd("colorscheme PaperColor")
-- spellcheck when in latex or in vimwiki
cmd("autocmd BufEnter,WinEnter,FocusGained *.tex set spelllang=en_gb spell")
-- close nvim-tree
cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
--close telescope
cmd("autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif")
-- enter insert mode when tabbing into a shell
cmd("autocmd BufEnter term://* startinsert")
-- don't close tags if in vimwiki
cmd[[ 
autocmd FileType vimwiki inoremap <buffer> ' '| inoremap <buffer> " "| inoremap <buffer> ( (| inoremap <buffer> { {| inoremap <buffer> ?? ??
]]
--relative line numbers depending on insert / normal mode
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
cmd('highlight ColorColumn guibg=#89748a') -- pink
cmd[[
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
]]

--disabled plugins and associated commands
--########################################
-- close nerdtree automatically
--cmd("autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
-- for dracula theme
--cmd('hi StatusLine guibg=#424450')
--cmd('highlight ColorColumn guibg=#424450') -- dracula dark grey
--cmd('highlight ColorColumn guibg=#678686') -- same as status bar

