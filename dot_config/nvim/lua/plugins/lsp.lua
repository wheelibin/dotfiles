return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP Support
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'ray-x/lsp_signature.nvim' },
    { 'j-hui/fidget.nvim' },
    { 'jose-elias-alvarez/typescript.nvim' },
    -- Autocompletion
    { 'ms-jpq/coq_nvim' },
    { 'ms-jpq/coq.artifacts' },
  },
  config = function()
    local servers = {
      'clangd', 'html', 'marksman', 'jsonls', 'gopls', 'lua_ls',
      'tsserver'
    }

    local legendary = require('legendary')
    local legendary_toolbox = require('legendary.toolbox')

    legendary.keymaps({
      { '<M-C-S-n>', vim.diagnostic.goto_next, description = 'Next Diagnostics message' },
      { '<M-C-S-e>', vim.diagnostic.goto_prev, description = 'Prev Diagnostics message' },
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

      require('lsp-inlayhints').on_attach(client, bufnr)

      require('lsp_signature').on_attach({
        bind = true,
        hint_enable = false,
        timer_interval = 100
      })
    end

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local lsp = require("lspconfig")
    local coq = require("coq")
    require("fidget").setup()

    -- Tell the server the capability of foldingRange,
    -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

    require("mason").setup()
    require("mason-lspconfig").setup({ automatic_installation = true })

    local lspconfig = require('lspconfig')

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
        on_attach = on_attach,
        capabilities = capabilities
      }))
    end


    -- -- typescript specific config
    -- require('typescript').setup({
    --     server = {
    --         settings = {
    --             -- typescript = {
    --             --     inlayHints = {
    --             --         includeInlayParameterNameHints = 'all',
    --             --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             --         includeInlayFunctionParameterTypeHints = true,
    --             --         includeInlayVariableTypeHints = true,
    --             --         includeInlayPropertyDeclarationTypeHints = true,
    --             --         includeInlayFunctionLikeReturnTypeHints = true,
    --             --         includeInlayEnumMemberValueHints = true
    --             --     }
    --             -- },
    --             -- javascript = {
    --             --     inlayHints = {
    --             --         includeInlayParameterNameHints = 'all',
    --             --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             --         includeInlayFunctionParameterTypeHints = true,
    --             --         includeInlayVariableTypeHints = true,
    --             --         includeInlayPropertyDeclarationTypeHints = true,
    --             --         includeInlayFunctionLikeReturnTypeHints = true,
    --             --         includeInlayEnumMemberValueHints = true
    --             --     }
    --             -- }
    --         },
    --         on_attach = on_attach,
    --         capabilities = capabilities
    --     }
    --
    -- })
    --
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

    vim.lsp.handlers['textDocument/hover'] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

    vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help,
          { focusable = false, border = 'rounded' })
  end
}
