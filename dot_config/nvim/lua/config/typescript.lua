local legendary = require('legendary')
local legendary_toolbox = require('legendary.toolbox')

local on_attach = function(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  legendary.keymaps({
    {
      'gD',
      vim.lsp.buf.declaration,
      description = 'Go to declaration (LSP)',
      buffer = bufnr
    }, {
      'gd',
      vim.lsp.buf.definition,
      description = 'Go to definition (LSP)',
      buffer = bufnr
    },
    {
      '<C-space>',
      vim.lsp.buf.hover,
      description = 'LSP Info',
      buffer = bufnr
    }, {
      'gi',
      vim.lsp.buf.implementation,
      description = 'Go to implementation (LSP)',
      buffer = bufnr
    }, {
      '<leader>rn',
      vim.lsp.buf.rename,
      description = 'Rename (LSP)',
      buffer = bufnr
    }, {
      '<leader>ca',
      vim.lsp.buf.code_action,
      description = 'Code Action(s) (LSP)',
      buffer = bufnr
    }, {
      '<leader>f',
      legendary_toolbox.lazy(vim.lsp.buf.format, { async = true }),
      description = 'Format buffer (LSP)',
      buffer = bufnr
    }
  })

  require('lsp-inlayhints').on_attach(client, bufnr)

  require('lsp_signature').on_attach({
    bind = true,
    hint_enable = false,
    timer_interval = 100
  })


end



require('typescript').setup({
server = {
settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  },
on_attach = on_attach
}
})
