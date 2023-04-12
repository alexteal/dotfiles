local vim = vim
vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
      recommended = false,
  },
  clients = {
      tabnine = {
          enabled = true,
      },
  },
}

require'lspconfig'.eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})
require'lspconfig'.lua_ls.setup({})
require'lspconfig'.jdtls.setup({})
require'lspconfig'.pyright.setup({})
require'lspconfig'.rust_analyzer.setup({})
require'lspconfig'.texlab.setup({})
require'lspconfig'.dockerls.setup({})
require'lspconfig'.cmake.setup({})
require'lspconfig'.tsserver.setup({})
require'lspconfig'.bashls.setup({})

require ('mason').setup({})
