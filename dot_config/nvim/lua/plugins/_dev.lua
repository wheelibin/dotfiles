local map = require('../utils').map

return {

  {
    'folke/trouble.nvim',
    lazy = true,
    keys = {
      { "<leader>t", "<cmd>troubletoggle workspace_diagnostics<cr>", desc = "toggle trouble" }
    },
    config = function()
      require("trouble").setup {}
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = "BufEnter",
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          map('n', '<M-C-S-h>', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '<M-C-S-,>', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })
        end
      })
    end
  },

  {
    "tpope/vim-fugitive",
    lazy = true,
    keys = {
      { "<leader>g", ":G<cr>", desc = "Git client" }
    },
  },

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
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/typescript.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },

      { 'lvimuser/lsp-inlayhints.nvim' },
      { 'j-hui/fidget.nvim',                  tag = 'legacy' },
      -- Autocompletion
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      -- snippets
      {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      local servers = {
        'html',
        'marksman',
        'jsonls',
        'gopls',
        'graphql',
        'lua_ls',
        -- 'tsserver',
        'bufls',
        'sqlls'
      }

      map("n", '<M-C-S-n>', vim.diagnostic.goto_next, { desc = 'Next Diagnostics message' })
      map("n", '<M-C-S-e>', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostics message' })

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        map("n", 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration (LSP)', buffer = bufnr })
        map("n", 'gd', vim.lsp.buf.definition, { desc = 'Goto definition (LSP)', buffer = bufnr })
        map("n", 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation (LSP)', buffer = bufnr })
        map("n", '<C-space>', vim.lsp.buf.hover, { desc = 'LSP Info', buffer = bufnr })
        map("n", '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename (LSP)', buffer = bufnr })
        map("n", '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Actions (LSP)', buffer = bufnr })
        map("n", '<leader>f', function() vim.lsp.buf.format({ async = true }) end,
          { desc = 'Format buffer', buffer = bufnr })

        -- require('lsp-inlayhints').on_attach(client, bufnr)
      end

      require("luasnip.loaders.from_vscode").lazy_load()
      require "fidget".setup {}

      local cmp = require 'cmp'
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'nvim_lsp_signature_help' }
        }, {
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')

      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities
        })
      end

      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
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
      }
      )

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
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.golangci_lint,
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
          }),
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
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'html',
          'go',
          'graphql',
          'javascript',
          'json',
          'lua',
          'python',
          'typescript',
          'tsx',
          'vim',
          'regex',
          'markdown',
          'markdown_inline',
          'yaml'
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false
        },

        indent = { enable = true },
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     init_selection = '<c-space>',
        --     node_incremental = '<c-space>',
        --     scope_incremental = '<c-s>',
        --     node_decremental = '<M-space>',
        --   },
        -- },

      }
    end
  }

  -- {
  --   'mfussenegger/nvim-dap',
  --   dependencies = {
  --     { 'leoluz/nvim-dap-go' }
  --   },
  --   config = function()
  --     require('dap-go').setup()
  --     vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
  --     vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
  --     vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
  --     vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
  --     vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
  --     vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
  --     vim.keymap.set('n', '<Leader>lp',
  --       function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  --     vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
  --     vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
  --     vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  --       require('dap.ui.widgets').hover()
  --     end)
  --     vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  --       require('dap.ui.widgets').preview()
  --     end)
  --     vim.keymap.set('n', '<Leader>df', function()
  --       local widgets = require('dap.ui.widgets')
  --       widgets.centered_float(widgets.frames)
  --     end)
  --     vim.keymap.set('n', '<Leader>ds', function()
  --       local widgets = require('dap.ui.widgets')
  --       widgets.centered_float(widgets.scopes)
  --     end)
  --   end
  -- }

}
