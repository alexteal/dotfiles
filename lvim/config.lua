--------------------------------------------------------------------------------
--
--                      Hi. Welcome to my config!
--                               03/19/2024
--      I'm Alex, and I used to use a heavily modified custom Neovim.
--
--      It started annoying me, because each change resulted in a 
--      cascade of issues since I never optimized anything - I just 
--      relied on having a ~fast enough~ computer to handle the complexity.
--
--      So, now I use LunarVim. It's nice to have a more managed version of 
--      Neovim. Mostly I use it for portability. 
--
--      If you are reading this, that means you're interested in my config.
--      I'm usually pretty responsive, so if you need help on making something
--      work, just send me an email. It's on my profile.
--
--------------------------------------------------------------------------------
-- use this for controlling python env 
-- vim.g.python3_host_prog = os.getenv('NEOVIM_PY_PATH')
--------------------------------------------------------------------------------
-- OG vim opts from back when I used native vim :P 
local opt = vim.opt
opt.showmatch = true		-- show matching
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true             -- incremental search
opt.tabstop = 4             -- number of columns occupied by a tab
opt.softtabstop = 4         -- see multiple spaces as tabstops so <BS> does the right thing
opt.expandtab = true              -- converts tabs to white space
opt.shiftwidth = 4          -- width for autoindents
opt.autoindent = true            -- indent a new line the same amount as the line just typed
opt.number = true                -- add line numbers
opt.wildmode = 'longest:full,full' -- get bash-like tab completions
opt.cc = '80'                -- set an 80 column border for good coding style
opt.syntax = 'on'         -- syntax highlighting
opt.mouse = 'a'              -- enable mouse click
opt.clipboard = 'unnamedplus'-- using system clipboard
opt.ttyfast = true               -- Speed up scrolling in Vim
opt.encoding = 'UTF-8'
-- longer wait time for keymap
opt.timeoutlen = 1750 -- in ms
opt.scrolloff = 8 -- keep 8 lines above/below cursor
opt.relativenumber = true
opt.spell = true
opt.spelllang = "en_us"
vim.g.vimwiki_list = {
    {path = '~/vimwiki/',
    syntax = 'markdown',
    ext = 'md'}
}

--------------------------------------------------------------------------------
--******************************************************************************
-- catpuccin theme handler
--******************************************************************************
-- FYI, if you're running this config for the first time and it's NOT working,
-- try commenting out this section and running the config again. Usually it 
-- fails because it tries to load the catppuccin theme - which isn't installed 
-- yet. 
--******************************************************************************
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end
--local theme = require("me.theme") or "macchiato" -- use the lua variable or "macchiato" as default
local theme = 'macchiato'
vim.g.catppuccin_flavour = theme
catppuccin.setup()

lvim.colorscheme = "catppuccin"

lvim.leader = "\\"
--******************************************************************************
--------------------------------------------------------------------------------
-- custom functions

function lvim.newshell()
    local name=vim.api.nvim_buf_get_name(0)
    if string.find(name,"term://") then
        vim.api.nvim_command('q')
        return
    else
        vim.api.nvim_command('belowright 15split term://zsh')
        vim.api.nvim_command('hi ActiveWindow guibg=#17252c | setl winhighlight=Normal:ActiveWindow')
        vim.o.winfixwidth = true
        vim.o.winfixheight = true
        return
    end
end

--------------------------------------------------------------------------------
--legacy nvim/vim configs
-- spellcheck when in latex or in vimwiki
vim.cmd("autocmd BufEnter,WinEnter,FocusGained *.tex set spelllang=en_gb spell")
--close telescope
vim.cmd("autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif")
-- enter insert mode when tabbing into a shell
vim.cmd("autocmd BufEnter term://* startinsert")
-- don't close tags if in vimwiki
vim.cmd[[ 
autocmd FileType vimwiki inoremap <buffer> ' '| inoremap <buffer> " "| inoremap <buffer> ( (| inoremap <buffer> { {| inoremap <buffer> ?? ??
]]
--relative line numbers depending on insert / normal mode
vim.cmd[[
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif 
autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif ]]

--------------------------------------------------------------------------------
-- plugins

lvim.plugins = {
    {
        'wfxr/minimap.vim',
        build = "cargo install --locked code-minimap",
        cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
        config = function ()
            vim.cmd ("let g:minimap_width = 10")
            vim.cmd ("let g:minimap_auto_start = 1")
            vim.cmd ("let g:minimap_auto_start_win_enter = 1")
        end,
    },
    { "catppuccin/nvim", name = "catppuccin" },
    { 'lambdalisue/suda.vim' },
    -- startup screen
    { 'mhinz/vim-startify' },
    -- color theme
    { "catppuccin/nvim", name = "catppuccin" },
    -- async processes
    { 'nvim-lua/plenary.nvim'},
    -- sudo while non-superuser
    { 'lambdalisue/suda.vim' },
    --{ 'sindrets/diffview.nvim' },
    { 'ms-jpq/chadtree',
        branch = 'chad',
        build = 'python3 -m chadtree deps',
    },
    -- easy keymap config, over in lua/me/keymaps.lua
    { 'LionC/nest.nvim' },
    -- floating windows,, Telescope config
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {'fannheyward/telescope-coc.nvim'},
            {'kdheepak/lazygit.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'xiyaowong/telescope-emoji.nvim' },
        },
        config = function()
    require('telescope').load_extension('lazygit')
            require("telescope").load_extension("emoji")
            require('telescope').setup()
        end,
    },
    -- telescope Chat-GPT plugin
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require'chatgpt'.setup({
                keymaps = {
                    submit = {
                        "<C-s>"
                    },
                },
            })
        end,
    },

    { 'vimwiki/vimwiki' },
    { 'norcalli/nvim-colorizer.lua' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
        config = function() require('colorizer').setup() end,
    },
    { 'simeji/winresizer' },

    -- transparent background on load (trying this out==Sun 25 Jun 2023 08:57:12 PM EDT==)
    { 'xiyaowong/transparent.nvim', event = { 'BufEnter', 'BufRead' } },

    { 'rinx/nvim-minimap' },

    {
        "lervag/vimtex",
        init = function()
            -- Use init for configuration, don't use the more common "config".
        end
    },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require'nvim-treesitter.configs'.setup {
              autotag = {
                enable = true,
              }
            }
        end
     },
    { 'sbdchd/neoformat' },
    { 'goolord/alpha-nvim', enabled = false}
}

--------------------------------------------------------------------------------
-- keymaps
lvim.builtin.which_key.mappings ={
    -- normal mode maps
    {
        mode = "n",
        f = {
            b = { "<cmd>Telescope buffers<CR>", "Find Buffer" },
            c = { "<cmd>Telescope commands<CR>", "Find Command" },
            d = { "<CMD>Telescope diagnostics<CR>", "Find Diagnostics" },
            e = { "<cmd>Telescope emoji<CR>", "Find Emoji" },
            f = { "<CMD>Telescope fd<CR>", "Find File" },
            h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
            ["if"] = { "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Find in File" },
            ib = { "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Find in Buffer" },
            k = { "<CMD>Telescope keymaps<CR>", "Find Keymap" },
            l = { "<CMD>Telescope coc document_symbols<CR>", "Find Document Symbols" },
            p = { "<CMD>Lazy<CR>", "Manage Plugins"},
            tf = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={'%:p:h'} }<CR>", "Find in Folder" },
            r = { "<cmd>Telescope registers<CR>", "Find Registers" },
            v = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Find Workspace Symbols" },
        },
        ai = { "<CMD>ChatGPT<CR>", "ChatGPT" },
        cpd = { "<CMD>Copilot disable<CR>", "Copilot Disable" },
        cpe = { "<CMD>Copilot enable<CR>", "Copilot Enable" },
        cpp = { "<CMD>Copilot panel<CR>", "Copilot Panel" },
        bb = { "<c-6>", "Jump to Previous Buffer" },
        da = { "i<return><esc><up><cmd>put =strftime('%c')<CR>i<backspace># <Esc><S-a><esc><S-a><return>", "Datetime" },
        hex = { "<cmd>file %.hexdump<CR><cmd>%!xxd<CR><cmd>set syntax=xxd<CR>", "Hexdump" },
        jd = { "<cmd>CocCommand java.debug.vimspector.start<CR>", "Java Debug" },
        js = { "<cmd>JsDoc<CR>", "JsDoc" },
        lg = { "<cmd>LazyGit<CR>", "LazyGit" },
        m = { "<cmd>MinimapToggle<cr>", "Minimap Toggle" },
        O = { "<CMD>TransparentToggle<CR>", "Transparent Toggle" },
        wp = { "<cmd>Files ~/vimwiki/<CR>", "Vimwiki Files" },
        e = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Search Buffer" },
        sf = { "<cmd>Telescope live_grep<CR>", "Search Folder" },
        sh = { lvim.newshell, "Open Terminal" },
        stf = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={'%:p:h'} }<CR>", "Search in Folder" },
        t = { "<CMD>CHADopen<CR>", "CHADopen" },
        rr = { "<CMD>LvimReload<CR>", "Source Vimrc" },
        qe = {"<CMD>tabnew ~/.config/lvim/config.lua<CR>", "quick edit config"},
        v = {
            name = "Vimspector",
            b = { "<cmd>call vimspector#ToggleBreakpoint()<CR>", "Toggle Breakpoint" },
            c = { "<cmd>call vimspector#Continue()<CR>", "Continue" },
            p = { "<cmd>call vimspector#Pause()<CR>", "Pause" },
            s = {
                name = "Step",
                i = { "<cmd>call vimspector#StepInto()<CR>", "Step Into" },
                o = { "<cmd>call vimspector#StepOver()<CR>", "Step Over" },
                O = { "<cmd>call vimspector#StepOut()<CR>", "Step Out" },
            },
            C = { "<cmd>call vimspector#ClearBreakpoints()<CR>", "Clear Breakpoints" },
            x = { "<cmd>VimspectorReset<CR>", "Vimspector Reset" },
        },
    }
}
lvim.keys.normal_mode["<RightMouse>"] = "y"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode["<LEADER>P"] = "<CMD>source $HOME/Session.vim<CR>"
lvim.keys.normal_mode["<LEADER>S"] = "<CMD>mksession! $HOME/Session.vim<CR>"
lvim.keys.normal_mode["<LeftMouse>"] = "<LeftMouse>i"
lvim.keys.normal_mode["<c-x>"] = "<cmd>call vimspector#Continue()<CR>"
lvim.keys.normal_mode["<C-w><C-h>"] = "<CMD>WinResizerStartResize<CR>h"
lvim.keys.normal_mode["<C-w><C-j>"] = "<CMD>WinResizerStartResize<CR>j"
lvim.keys.normal_mode["<C-w><C-k>"] = "<CMD>WinResizerStartResize<CR>k"
lvim.keys.normal_mode["<C-w><C-l>"] = "<CMD>WinResizerStartResize<CR>l"
lvim.keys.insert_mode["??"] = "<Esc>"
lvim.keys.insert_mode["jj"] = "<Esc>"
lvim.keys.insert_mode["'"] = "''<left>"
lvim.keys.insert_mode['"'] = '""<left>'
lvim.keys.insert_mode["("] = "()<left>"
lvim.keys.insert_mode["["] = "[]<left>"
lvim.keys.insert_mode["{"] = "{}<left>"
lvim.keys.insert_mode["{<CR>"] = "{<CR>}<ESC>O"
lvim.keys.insert_mode["{;<CR>"] = "{<CR>};<ESC>O"
lvim.keys.insert_mode["<C-w>"] = "<Esc><C-w>"
lvim.keys.term_mode["<C-w>"] = "<C-\\><C-n>"
lvim.keys.term_mode["<leader>sh"] = lvim.newshell
lvim.keys.visual_mode["<leader>ai"] = "<CMD>ChatGPTEditWithInstructions<CR>"
lvim.keys.visual_mode["\\"] = "<Esc>"

--------------------------------------------------------------------------------
-- lsp and formatters
local lspconfig = require('lspconfig')
lspconfig.eslint.setup({})

vim.cmd[[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]]
--------------------------------------------------------------------------------
