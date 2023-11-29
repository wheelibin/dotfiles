local map = require('../utils').map

return {

  {
    'folke/trouble.nvim',
    lazy = true,
    keys = {
      { "<leader>t", ":TroubleToggle workspace_diagnostics<cr>", desc = "toggle trouble" }
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
          end, { expr = true, desc = "Goto next change/hunk (GIT)" })

          map('n', '<M-C-h>', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Goto previous change/hunk (GIT)" })

          map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset change/hunk (GIT)" })
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
    lazy = true,
    event = "BufRead",
    dependencies = {
      'nvim-telescope/telescope.nvim', -- for popups,
      -- LSP Support
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
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
      -- typescript
      { "pmizio/typescript-tools.nvim" }
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

      local lsp_on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        map("n", 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration (LSP)', buffer = bufnr })

        map("n", 'gd', vim.lsp.buf.definition, { desc = 'Goto definition (LSP)', buffer = bufnr })

        -- currently handled by fzf-lua
        -- map("n", 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation (LSP)', buffer = bufnr })

        map("n", '<C-Space>', vim.lsp.buf.hover, { desc = 'LSP Hover Info', buffer = bufnr })
        map("n", '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename (LSP)', buffer = bufnr })

        -- currently handled by fzf-lua
        -- map({ "n", "v" }, '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'Code Actions (LSP)', buffer = bufnr })

        map("n", '<leader>f', function() vim.lsp.buf.format({ async = true }) end,
          { desc = 'Format buffer', buffer = bufnr })
      end

      -- diag
      map("n", '<M-C-S-n>', vim.diagnostic.goto_next, { desc = 'Next Diagnostics message' })
      map("n", '<M-C-n>', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostics message' })

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
          on_attach = lsp_on_attach,
          capabilities = capabilities
        })
      end
      require("typescript-tools").setup({
        on_attach = lsp_on_attach,
        capabilities = capabilities
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
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = {
      { 'leoluz/nvim-dap-go' },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
          require('nvim-dap-virtual-text').setup()
        end
      },
      {
        'mfussenegger/nvim-dap',
        config = function()
          require('dap-go').setup()
        end
      }
    },
    keys = {
      { '<Leader>b',  function() require('dap').toggle_breakpoint() end, desc = "DAP continue" },
      { '<Leader>dr', function() require('dap').repl.open() end,         desc = "DAP repl open" },
      { '<F5>',       function() require('dap').continue() end,          desc = "DAP continue" },
      { '<F10>',      function() require('dap').step_over() end,         desc = "DAP step over" },
      { '<F11>',      function() require('dap').step_into() end,         desc = "DAP step into" },
      { '<F12>',      function() require('dap').step_out() end,          desc = "DAP step out" },
    },

    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    lazy = true,
    keys = {
      { "<leader>x", "<Plug>RestNvim", desc = "Execute request" }
    },

    config = function()
      require("rest-nvim").setup({
        --- Get the same options from Packer setup
        result_split_in_place = true
      })
    end
  }

}
