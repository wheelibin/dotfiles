local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.gitsigns,
    -- require("typescript.extensions.null-ls.code-actions"),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.lua_format.with({
      extra_args = {
        "-i", "--no-keep-simple-function-one-line",
        "--no-keep-simple-control-block-one-line", "--tab_width=2",
        "--column_limit=120"
      }
    })
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
})
