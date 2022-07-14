set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
"let g:python3_host_prog = '/Library/Developer/CommandLineTools/usr/bin/python3'
"let g:ruby_host_prog ='/Users/AT185301/.rbenv/versions/3.1.2/bin/ruby'
set encoding=UTF-8


"GRUVBOX
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX)) 
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
endif
" END GRUVBOX

if (has("termguicolors"))
    set termguicolors
endif


call plug#begin('~/.config/nvim/plugged')

" dracula theme
Plug 'Mofiqul/dracula.nvim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Nerd tree setup
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Toggle nerdtree with \t
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


Plug 'https://github.com/junegunn/vim-github-dashboard.git'

let g:github_dashboard = { 'username': $GIT_USER, 'password': $GIT_SECRET}
" set 

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" tab bar
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Initialize plugin system
Plug 'mfussenegger/nvim-jdtls'
" better command completion
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" fuzzy finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do' : 'make' }
" Scala support
Plug 'scalameta/nvim-metals'

lua << EOF
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = nvim_metals_group,
})
EOF

Plug 'derekwyatt/vim-scala'
Plug 'kevinhwang91/nvim-bqf'
" better parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'dracula/vim'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'dense-analysis/ale'

Plug 'rickhowe/diffchar.vim'
Plug 'vimwiki/vimwiki'
"let g:vimwiki_autowriteall = 1
"better python highlighting
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': expand('%:p:h')}, <bang>0)

" HTML autocompletion. 
" use > to cycle through auto completes with tags
Plug 'alvan/vim-closetag'
"define which file extensions the plugin is enabled on
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.tsx'


" ESLinter setup
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/eslint.nvim'

" uses eslint.vim
" Prettier
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx', 'jsx', 'typescriptreact'] }

let g:prettier#quickfix_enabled = 0
let g:prettier#exec_cmd_async = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
"vim checklist
Plug 'evansalter/vim-checklist'
" Debugger. Can attach to a running program and set breakpoints to debug. 
Plug 'mfussenegger/nvim-dap'
" Must install adapters for each language. This is not setup yet, so this
" debugger will not work. Once you have a good reason to dive into this, 
" here's some documentation
"https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

" Scala linting with Neomake
"Linting with neomake
Plug 'neomake/neomake'
let g:neomake_sbt_maker = {
      \ 'exe': 'sbt',
      \ 'args': ['-Dsbt.log.noformat=true', 'compile'],
      \ 'append_file': 0,
      \ 'auto_enabled': 1,
      \ 'output_stream': 'stdout',
      \ 'errorformat':
          \ '%E[%trror]\ %f:%l:\ %m,' .
            \ '%-Z[error]\ %p^,' .
            \ '%-C%.%#,' .
            \ '%-G%.%#'
     \ }
let g:neomake_enabled_makers = ['sbt']
""let g:neomake_verbose=3
""let g:neomake_open_list = 2
" Neomake on text change
autocmd InsertLeave,TextChanged *.scala update | Neomake! sbt

" Lua Dev setup
" completions, etc. has more config in lua format available
Plug 'tjdevries/nlua.nvim'"
" better syntax
Plug 'euclidianAce/BetterLua.vim'
" 
call plug#end()

" Themes 
" colorscheme gruvbox
colorscheme dracula

lua << telescope
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
telescope
lua << snippet
--format_diary_newline = function()
--    local path = vim.api.nvim_buf_get_name(0)
--    if string.match(path, "vimwiki/diary.*.wiki") then
--        local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
--        content = table.concat(content, "\n")
--        local count = 1
--        local whitespace = 0
--        for i = 1, #content do 
--            local c = content:sub(i,i)
--            if c == ' ' then
--                whitespace = i - count
--            end
--            if count >= 80 then
--                while c != '\n' do
--                    i = i + 1
--                    c = content:sub(i,i)
--                end 
--                
--            end
--            if count > 80 and c == ' ' then
--               whitespace = i-count  -- most recent whitespace after char 80
--            elseif count > 80 and c == '\n' then 
--                -- remove the linebreak here, then reformat the line by placing
--                -- a linebreak at step, 
--                count = 0 
--                -- go to 80th char of line, then 
--                -- search backwards for most recent whitespace. use that 
--                -- whitespace as location for new linebreak. remove old linebreak of that
--                -- line, and place new linebreak down then restart loop from index
--                -- of new linebreak. 
--            end
--            count = count + 1
--        end 
--        return 
--    end
--    return
--end
--local Diary = vim.api.nvim_create_augroup("Diary", { clear = true })
--local format_diary = vim.api.nvim_create_autocmd(
--    { "BufEnter", "InsertLeave" },
--    { pattern = "*.wiki", 
--        command = "lua format_diary_newline()", group = Diary })
snippet

" close terminal easier
tnoremap jj  <C-\><C-n>
" open shell with 15 lines of height on bottom
nnoremap <Leader>sh <cmd>belowright 15split term://zsh<CR>

nnoremap <leader>ct <cmd>ChecklistToggleCheckbox<cr>
nnoremap <leader>ce <cmd>ChecklistEnableCheckbox<cr>
nnoremap <leader>cd <cmd>ChecklistDisableCheckbox<cr>
" find files
nmap <Leader>ff <cmd>FZF<CR>
" Search for function documentation
nmap <Leader>fh <cmd>Telescope help_tags<CR>
" Search for command
nmap <Leader>fc <cmd>Telescope commands<CR> 
" wiki page
nmap <Leader>wp <cmd>Files ~/vimwiki/<CR>
" search in files
nmap <Leader>sf <cmd>Telescope live_grep<CR>
" ripgrep alternative if slow
nmap <Leader>fs <cmd>PRg<CR>
" telescope search command
nmap <Leader>gd <cmd>GHDashboard<CR>
nmap <Leader>gh <cmd>GHActivity<CR>

nmap <Leader>t <cmd>NERDTreeToggle<CR>

" VSCode mouse mode
map <LeftMouse> <LeftMouse>i

"Put date time with equals on either side
nmap <Leader>da i<return><esc><up><cmd>put =strftime('%c')<CR>i<backspace>==<Esc><S-a>==<esc><S-a><return>
" vertical split vimwiki link
nmap <Leader>vs <cmd>VimwikiVSplitLink<CR>

" Set hybrid line numbers
" set number relativenumber
" Smart toggle line number display depending on viewed buffer
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

imap jj <Esc>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs js " . 0x2C7C
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093

execute "digraphs aS " . 0x1d43
execute "digraphs bS " . 0x1d47
execute "digraphs cS " . 0x1d9c
execute "digraphs dS " . 0x1d48
execute "digraphs eS " . 0x1d49
execute "digraphs fS " . 0x1da0
execute "digraphs gS " . 0x1d4d
execute "digraphs hS " . 0x02b0
execute "digraphs iS " . 0x2071
execute "digraphs jS " . 0x02b2
execute "digraphs kS " . 0x1d4f
execute "digraphs lS " . 0x02e1
execute "digraphs mS " . 0x1d50
execute "digraphs nS " . 0x207f
execute "digraphs oS " . 0x1d52
execute "digraphs pS " . 0x1d56
execute "digraphs rS " . 0x02b3
execute "digraphs sS " . 0x02e2
execute "digraphs tS " . 0x1d57
execute "digraphs uS " . 0x1d58
execute "digraphs vS " . 0x1d5b
execute "digraphs wS " . 0x02b7
execute "digraphs xS " . 0x02e3
execute "digraphs yS " . 0x02b8
execute "digraphs zS " . 0x1dbb

execute "digraphs AS " . 0x1D2C
execute "digraphs BS " . 0x1D2E
execute "digraphs DS " . 0x1D30
execute "digraphs ES " . 0x1D31
execute "digraphs GS " . 0x1D33
execute "digraphs HS " . 0x1D34
execute "digraphs IS " . 0x1D35
execute "digraphs JS " . 0x1D36
execute "digraphs KS " . 0x1D37
execute "digraphs LS " . 0x1D38
execute "digraphs MS " . 0x1D39
execute "digraphs NS " . 0x1D3A
execute "digraphs OS " . 0x1D3C
execute "digraphs PS " . 0x1D3E
execute "digraphs RS " . 0x1D3F
execute "digraphs TS " . 0x1D40
execute "digraphs US " . 0x1D41
execute "digraphs VS " . 0x2C7D
execute "digraphs WS " . 0x1D42
execute "digraphs 0D " . 0x03F4
