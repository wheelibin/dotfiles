return {
  {
    "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    -- lazy = false,            -- REQUIRED: tell lazy.nvim to start this plugin at startup
    event = "BufRead",
    dependencies = {
      -- main one
      { "ms-jpq/coq_nvim",       branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" },
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc

      -- LSP Support
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- better ui
      { 'j-hui/fidget.nvim' },

      -- -- snippets
      -- {
      --   'L3MON4D3/LuaSnip',
      --   dependencies = { "rafamadriz/friendly-snippets" },
      -- },

      -- typescript
      { "yioneko/nvim-vtsls" },


    },
    init = function()
      vim.g.coq_settings = {
        auto_start = true, -- if you want to start COQ at startup
        -- Your COQ settings here
        keymap = {
          recommended = false,
        },
        display = {
          statusline = {
            helo = false
          }
          --   preview = {
          --     border = {
          --       { "",  "NormalFloat" },
          --       { "",  "NormalFloat" },
          --       { "",  "NormalFloat" },
          --       { " ", "NormalFloat" },
          --       { "",  "NormalFloat" },
          --       { "",  "NormalFloat" },
          --       { "",  "NormalFloat" },
          --       { " ", "NormalFloat" }
          --     }
          --   }
        }
      }

      vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], { expr = true, silent = true })
      vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], { expr = true, silent = true })
      vim.api.nvim_set_keymap('i', '<BS>', [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
      vim.api.nvim_set_keymap(
        "i",
        "<CR>",
        [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
        { expr = true, silent = true }
      )
      -- vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
      -- vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })
    end,
    config = function()
      local servers = {
        'html',
        'marksman',
        'jsonls',
        'gopls',
        'golangci_lint_ls',
        'graphql',
        'lua_ls',
        'pylsp',
        'bufls',
        'sqlls',
        'vtsls',
        'yamlls'
        -- 'cucumber_language_server'
      }

      local lsp_on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration (LSP)', buffer = bufnr })

        vim.keymap.set("n", 'gd', vim.lsp.buf.definition, { desc = 'Goto definition (LSP)', buffer = bufnr })

        -- currently handled by fzf-lua
        --vim.keymap.set("n", 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation (LSP)', buffer = bufnr })

        vim.keymap.set("n", '<C-Space>', vim.lsp.buf.hover, { desc = 'LSP Hover Info', buffer = bufnr })
        vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename (LSP)', buffer = bufnr })

        -- currently handled by fzf-lua
        --vim.keymap.set({ "n", "v" }, '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'Code Actions (LSP)', buffer = bufnr })

        vim.keymap.set("n", '<leader>f', function() vim.lsp.buf.format({ async = true }) end,
          { desc = 'Format buffer', buffer = bufnr })

        pcall(function()
          require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end)
      end

      -- diag
      vim.keymap.set("n", '<M-C-S-n>', vim.diagnostic.goto_next, { desc = 'Next Diagnostics message' })
      vim.keymap.set("n", '<M-C-n>', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostics message' })

      -- require("luasnip.loaders.from_vscode").lazy_load()
      require "fidget".setup {}

      -- local cmp = require 'cmp'
      -- -- If you want insert `(` after select function or method item
      -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      -- cmp.event:on(
      --   'confirm_done',
      --   cmp_autopairs.on_confirm_done()
      -- )

      -- cmp.setup({
      --   snippet = {
      --     expand = function(args)
      --       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      --     end,
      --   },
      --   window = {
      --     completion = cmp.config.window.bordered(),
      --     documentation = cmp.config.window.bordered(),
      --   },
      --   mapping = cmp.mapping.preset.insert({
      --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
      --     ['<C-Space>'] = cmp.mapping.complete(),
      --     ['<C-e>'] = cmp.mapping.abort(),
      --     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      --   }),
      --   sources = cmp.config.sources({
      --     { name = 'nvim_lsp' },
      --     { name = 'luasnip' }, -- For luasnip users.
      --     { name = 'nvim_lsp_signature_help' },
      --     { name = 'cmp_tabnine' },
      --   }, {
      --     {
      --       name = 'buffer',
      --       option = {
      --         get_bufnrs = function()
      --           return vim.api.nvim_list_bufs()
      --         end
      --       }
      --     },
      --   })
      -- })

      -- -- Set configuration for specific filetype.
      -- cmp.setup.filetype('gitcommit', {
      --   sources = cmp.config.sources({
      --     { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      --   }, {
      --     { name = 'buffer' },
      --   })
      -- })
      --
      -- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })
      --
      -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' },
      --   })
      -- })

      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')

      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = lsp_on_attach,
          -- capabilities = capabilities
        })
      end

      -- lspconfig["cucumber_language_server"].setup({
      --     on_attach = lsp_on_attach,
      --     capabilities = capabilities,
      --     settings = {
      --         cucumber = {
      --           features = { "internal/cmdhandler/features/*.feature" },
      --           glue = { "internal/cmdhandler/features_test.go" }
      --          },
      --     }
      -- })

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
    end,
  }

}
