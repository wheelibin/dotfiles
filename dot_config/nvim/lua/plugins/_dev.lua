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
    'codota/tabnine-nvim',
    lazy = true,
    event = "BufEnter",
    build = "./dl_binaries.sh",
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end
  },

  {
    'tzachar/cmp-tabnine',
    lazy = true,
    event = "BufEnter",
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp',
    config = function()
      require('cmp_tabnine.config'):setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = false,
        min_percent = 0
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = "BufRead",
    dependencies = {
      -- LSP Support
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- { 'lvimuser/lsp-inlayhints.nvim' },
      { 'j-hui/fidget.nvim' },
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
        'pylsp',
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
          { name = 'nvim_lsp_signature_help' },
          { name = 'cmp_tabnine' },
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
          { name = 'cmdline' },
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
    end
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        go = { "goimports", "gofmt" },
        -- sql = { "sql_formatter" }
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    'mfussenegger/nvim-lint',
    event = "BufRead",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        go = { "golangcilint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      }
      local events = { "BufWritePost", "BufReadPost", "InsertLeave" }
      vim.api.nvim_create_autocmd(events, {
        callback = function()
          lint.try_lint()
        end,
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
  },

  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
      -- outline_window = {
      --   auto_jump = true
      -- }
    },
  },

}
