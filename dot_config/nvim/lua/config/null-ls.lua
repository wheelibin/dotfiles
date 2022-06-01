local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.tsc,
      null_ls.builtins.formatting.prettierd
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(clients)
                      return vim.tbl_filter(
                        function(filter_client)
                          return filter_client == "null-ls"
                        end,
                        clients
                      )
                    end
                  })
                end,
            })
        end
    end,
})

