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
    -- { 'ray-x/lsp_signature.nvim' },
    -- { 'lvimuser/lsp-inlayhints.nvim' },
    -- { 'j-hui/fidget.nvim' },
    { 'jose-elias-alvarez/typescript.nvim' },
    -- Autocompletion
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },

    { 'jose-elias-alvarez/null-ls.nvim' },

  },
  config = function()
    local servers = {
      -- 'clangd',
      'html',
      'marksman',
      'jsonls',
      -- 'gopls',
      'lua_ls',
      -- 'tsserver',
      'yamlls',
      'bufls'
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

      -- require('lsp-inlayhints').on_attach(client, bufnr)

      -- require('lsp_signature').on_attach({
      --   bind = true,
      --   hint_enable = true,
      --   timer_interval = 100
      -- })
    end

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()



    local lspconfig = require('lspconfig')
    -- require("fidget").setup()

    require("mason").setup()
    require("mason-lspconfig").setup({ automatic_installation = true })
    local cfg = require 'go.lsp'.config() -- config() return the go.nvim gopls setup
    lspconfig.gopls.setup(cfg)

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end

    local cmp = require 'cmp'

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
      })
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })

    -- typescript specific config
    require('typescript').setup({
      server = {
        -- settings = {
        --   typescript = {
        --     inlayHints = {
        --       includeInlayParameterNameHints = 'all',
        --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --       includeInlayFunctionParameterTypeHints = true,
        --       includeInlayVariableTypeHints = true,
        --       includeInlayPropertyDeclarationTypeHints = true,
        --       includeInlayFunctionLikeReturnTypeHints = true,
        --       includeInlayEnumMemberValueHints = true
        --     }
        --   },
        --   javascript = {
        --     inlayHints = {
        --       includeInlayParameterNameHints = 'all',
        --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --       includeInlayFunctionParameterTypeHints = true,
        --       includeInlayVariableTypeHints = true,
        --       includeInlayPropertyDeclarationTypeHints = true,
        --       includeInlayFunctionLikeReturnTypeHints = true,
        --       includeInlayEnumMemberValueHints = true
        --     }
        --   }
        -- },
        on_attach = on_attach,
        capabilities = capabilities
      }
    })

    require 'lspconfig'.bufls.setup {}


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



    local null_ls = require('null-ls')
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup({
      sources = {
        -- null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.code_actions.gitsigns,
        require("typescript.extensions.null-ls.code-actions"),
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
  end
}
