local opt = vim.opt
opt.showmatch = true		-- show matching
opt.ignorecase = true
opt.hlsearch = true
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
