require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- startup screen
    use { 'mhinz/vim-startify'}

    -- color theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- notifications
    use { 'rcarriga/nvim-notify' }

    -- async processes
    use { 'nvim-lua/plenary.nvim'}

    -- file tree 
    use { 'kyazdani42/nvim-web-devicons',
        disable = false ,
        config = function() require'nvim-web-devicons'.setup{} end,
    }

    use { 'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    -- easy keymap config, over in lua/me/keymaps.lua
    use { 'LionC/nest.nvim' }


    -- floating windows,, Telescope config
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
                {'fannheyward/telescope-coc.nvim'},
                {'kdheepak/lazygit.nvim'},
                { "nvim-lua/plenary.nvim"},
                { 'nvim-telescope/telescope-fzf-native.nvim',
                    cmd="make",
                    event = { "BufNewFile", "BufRead", "InsertEnter" },
                },
                { "kdheepak/lazygit.nvim",
                    event = { "BufNewFile", "BufRead", "InsertEnter" },
                }
            },
            config = function()
                require('telescope').load_extension('coc')
                require('telescope').load_extension('lazygit')
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

    -- lsp server install manager
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    -- lsp server configs
    use { 'neovim/nvim-lspconfig' }
    -- java linting, jdtls is hefty and uses own package
    -- config file is in ../../ftplugin/java.lua
    use { 'mfussenegger/nvim-jdtls' }
   
    -- snippets
    use { 'honza/vim-snippets',
        requires = 'SirVer/ultisnips' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
    }

    -- code completion using coq
    use { 'ms-jpq/coq_nvim', branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

    -- Prettier for webdev
    use { 'prettier/vim-prettier',
        run = 'yarn install --frozen-lockfile --production',
        ft={'javascript', 'typescript', 'css', 'less', 'scss', 'json',
        'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx','jsx',
        'typescriptreact'},
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'tjdevries/nlua.nvim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'euclidianAce/BetterLua.vim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" ,
        config = function()
        require('nvim-treesitter.configs').setup {
          highlight = {
              enabled = true
          }
        }
        end,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}

    -- jsx linting and pretty colors
    use { 'alvan/vim-closetag',
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
        ft={'javascript', 'typescript', 'css', 'less', 'scss', 'json',
        'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx','jsx',
        'typescriptreact'},
    }
    use { 'pangloss/vim-javascript',
        event  = { "BufNewFile", "BufRead", "BufEnter" },
        ft={'tsx','jsx'},
    }
    use { 'maxmellon/vim-jsx-pretty',
        event = {"BufNewFile", "BufRead", "BufEnter" },
        ft = {'tsx','jsx'},
    }

    -- assorted tools for different things
    
    

    -- latex support
    use { 'lervag/vimtex',
        ft = {"tex"},
    }
    -- wiki
    use { 'vimwiki/vimwiki' }
    -- colorizer for hex
    use { 'norcalli/nvim-colorizer.lua' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
        config = function() require('colorizer').setup() end,
    }
end)
