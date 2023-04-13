-- TODO convert to lua
local cmd = vim.api.nvim_command
-- disable copilot by default
--cmd("Copilot disable")
-- coclist sets cursor to invisible, but this prevents it from breaking
-- cmd("let g:coc_disable_transparent_cursor = 1")
-- set background and transparent color
-- autocmd fixes flicker on start
--cmd("autocmd! ColorScheme * highlight Normal ctermbg=NONE guibg=NONE")
--cmd("colorscheme PaperColor")
-- spellcheck when in latex or in vimwiki
cmd("autocmd BufEnter,WinEnter,FocusGained *.tex set spelllang=en_gb spell")
-- close nvim-tree
--cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
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
-- enable prettier when on corresponding filetypes
cmd[[
let g:prettier#quickfix_enabled = 0
let g:prettier#exec_cmd_async = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
]]
cmd[[
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
]]
-- cmd('highlight ColorColumn guibg=#89748a') -- pink column

-- auto save last session
cmd[[
" autocmd! VimLeave * mksession
]]
