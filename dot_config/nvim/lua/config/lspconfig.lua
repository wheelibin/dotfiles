-- lspconfig

-- typescript is setup separately below
local servers = { 'sumneko_lua', 'clangd', 'pylsp', 'html', 'marksman', 'jsonls', 'gopls' }

local legendary = require('legendary')
local legendary_toolbox = require('legendary.toolbox')

legendary.keymaps({
  { '[d', vim.diagnostic.goto_prev, description = 'Prev Diagnostics message' },
  { ']d', vim.diagnostic.goto_next, description = 'Next Diagnostics message' }
})

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

--  require('lsp-inlayhints').on_attach(client, bufnr)

  -- require('lsp_signature').on_attach({
  --   bind = true,
  --   hint_enable = false,
  --   timer_interval = 100
  -- })


end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true
})

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

lspconfig.sumneko_lua.setup({
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
})


-- typescript specific config
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
    on_attach = on_attach,
    capabilities = capabilities
  }

})

local sign = function(opts)
  vim.fn.sign_define(opts.name,
    { texthl = opts.name, text = opts.text, numhl = '' })
end
sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many', header = '', prefix = '' }
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
  { focusable = false, border = 'rounded' })
