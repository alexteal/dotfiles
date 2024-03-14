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

    -- sudo while non-superuser
    use { 'lambdalisue/suda.vim' }
    -- file tree 
    use { 'kyazdani42/nvim-web-devicons',
        disable = false ,
        config = function() require'nvim-web-devicons'.setup{} end,
    }

--      use { 'kyazdani42/nvim-tree.lua',
--          requires = { 'kyazdani42/nvim-web-devicons' },
--          config = function()
--              require ('me.nvim-tree-config')
--          end,
--      }
    use { 'sindrets/diffview.nvim' }
    use { 'ms-jpq/chadtree',
        branch = 'chad',
        run = 'python3 -m chadtree deps',
    }
    -- easy keymap config, over in lua/me/keymaps.lua
    use { 'LionC/nest.nvim' }

    -- floating windows,, Telescope config
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
                {'fannheyward/telescope-coc.nvim'},
                {'kdheepak/lazygit.nvim' },
                { 'nvim-lua/plenary.nvim' },
                { 'xiyaowong/telescope-emoji.nvim' },
                { 'nvim-telescope/telescope-fzf-native.nvim',
                    cmd="make",
                    event = { "BufNewFile", "BufRead", "InsertEnter" },
                },
                { "kdheepak/lazygit.nvim",
                    event = { "BufNewFile", "BufRead", "InsertEnter" },
                }
            },
            config = function()
                require('telescope').load_extension('lazygit')
                require("telescope").load_extension("emoji")
                require('telescope').setup({})
            end,
    })

    -- telescope Chat-GPT plugin
    use ({
      "jackMort/ChatGPT.nvim",
        requires = {
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
    })

    use { 'junegunn/fzf', run = './install --bin'}

    -- lsp server install manager
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    -- java linting, jdtls is hefty and uses own package
    -- config file is in ../../ftplugin/java.lua
    use { 'mfussenegger/nvim-jdtls' }
    -- snippets
    use { 'honza/vim-snippets',
        requires = 'SirVer/ultisnips' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
    }

    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim', {
        config = function()
            vim.cmd [[autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Prettier]]
        end
    })
    -- code completion using coq
    use { 'ms-jpq/coq_nvim', branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    -- esLint
    use { 'MunifTanjim/eslint.nvim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },
        config = function()
            local null_ls = require("null-ls")
            local eslint = require("eslint")

            null_ls.setup()

            eslint.setup({
              bin = 'eslint', -- or `eslint_d`
              code_actions = {
                enable = true,
                apply_on_save = {
                  enable = true,
                  types = { "directive", "problem", "suggestion", "layout" },
                },
                disable_rule_comment = {
                  enable = true,
                  location = "separate_line", -- or `same_line`
                },
              },
              diagnostics = {
                enable = true,
                report_unused_disable_directives = false,
                run_on = "type", -- or `save`
              },
            })
        end,
    }
    -- Prettier for webdev
--    use { 'prettier/vim-prettier',
--        run = 'yarn install --frozen-lockfile --production',
--        ft={'javascript', 'typescript', 'css', 'less', 'scss', 'json',
--        'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'tsx','jsx',
--        'typescriptreact'},
--        event  = { "BufNewFile", "BufRead", "InsertEnter" },
--            enable = false,
--        }
--
--

use { 'tjdevries/nlua.nvim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    use { 'euclidianAce/BetterLua.vim' ,
        event  = { "BufNewFile", "BufRead", "InsertEnter" },}
    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" ,
        requires = {
            'windwp/nvim-ts-autotag',
        },
        config = function()
        require('nvim-treesitter.configs').setup {
          highlight = {
              enable = true,
          },
          autotag = {
              enable = true,
          },
        }
        end,
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
    use { 'simeji/winresizer' }

    -- transparent background on load (trying this out==Sun 25 Jun 2023 08:57:12 PM EDT==)
    use { 'xiyaowong/transparent.nvim', event = { 'BufEnter', 'BufRead' } }

    use { 'rinx/nvim-minimap' }

    -- move windows easily
    -- TODO
    -- set this up in the future pls
    --    use { 'sindrets/winshift.nvim', event =  { "BufNewFile", "BufRead", "InsertEnter" } }

    -- matlab 
    -- jk this is really old
    -- use {'daeyun/vim-matlab'}

    -- I love this plugin, but it causes problems if you scroll too fast. 
    -- Might be an issue I can push something for.
    -- use { 'f-person/git-blame.nvim', event = { 'BufEnter', 'BufRead' } }
end)
