return {

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP Support
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
      },

      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/typescript.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'lvimuser/lsp-inlayhints.nvim' },
      -- Autocompletion
      { 'ms-jpq/coq_nvim' },
      { 'ms-jpq/coq.artifacts' }

    },
    config = function()
      local servers = {
        'html',
        'marksman',
        'jsonls',
        'gopls',
        'lua_ls',
        -- 'tsserver',
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

        require('lsp-inlayhints').on_attach(client, bufnr)
      end

      local coq = require("coq")

      vim.g.coq_settings = {
        ["keymap.pre_select"] = true,
        ["display.preview.border"] = {
          { "",  "NormalFloat" },
          { "",  "NormalFloat" },
          { "",  "NormalFloat" },
          { " ", "NormalFloat" },
          { "",  "NormalFloat" },
          { "",  "NormalFloat" },
          { "",  "NormalFloat" },
          { " ", "NormalFloat" }
        }
      }

      local lspconfig = require('lspconfig')

      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })
      -- local cfg = require 'go.lsp'.config() -- config() return the go.nvim gopls setup
      -- cfg.on_attach = on_attach
      -- cfg.capabilities = capabilities
      -- lspconfig.gopls.setup(cfg)

      require("lsp-inlayhints").setup()

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
          on_attach = on_attach,
        }))
      end

      lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
        on_attach = on_attach,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
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
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          }
        }
      }))
      -- require('typescript').setup(coq.lsp_ensure_capabilities({
      --   server = {
      --     settings = {
      --       typescript = {
      --         inlayHints = {
      --           includeInlayParameterNameHints = 'all',
      --           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --           includeInlayFunctionParameterTypeHints = true,
      --           includeInlayVariableTypeHints = true,
      --           includeInlayPropertyDeclarationTypeHints = true,
      --           includeInlayFunctionLikeReturnTypeHints = true,
      --           includeInlayEnumMemberValueHints = true
      --         }
      --       },
      --       javascript = {
      --         inlayHints = {
      --           includeInlayParameterNameHints = 'all',
      --           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --           includeInlayFunctionParameterTypeHints = true,
      --           includeInlayVariableTypeHints = true,
      --           includeInlayPropertyDeclarationTypeHints = true,
      --           includeInlayFunctionLikeReturnTypeHints = true,
      --           includeInlayEnumMemberValueHints = true
      --         }
      --       }
      --     },
      --     on_attach = on_attach,
      --     capabilities = capabilities
      --   }
      -- }))

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
  } }
