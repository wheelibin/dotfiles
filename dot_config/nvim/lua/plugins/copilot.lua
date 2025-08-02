return {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         auto_trigger = true
  --       },
  --       keymap = {
  --         accept = "<tab>",
  --         -- accept_word = false,
  --         -- accept_line = false,
  --         -- next = "<M-]>",
  --         -- prev = "<M-[>",
  --         -- dismiss = "<C-]>",
  --       },
  --     })
  --   end,
  -- },
  {
    'github/copilot.vim',
    lazy = true,
    event = "BufEnter",
    -- opts = {} -- this is equalent to setup({}) function
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   dependencies = {
  --     { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   build = "make tiktoken",                          -- Only on MacOS or Linux
  --   opts = {
  --     window = {
  --       layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
  --       -- width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
  --       -- height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
  --       -- -- Options below only apply to floating windows
  --       -- relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
  --       -- border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
  --       -- row = nil, -- row position of the window, default is centered
  --       -- col = nil, -- column position of the window, default is centered
  --       -- title = 'Copilot Chat', -- title of chat window
  --       -- footer = nil, -- footer of chat window
  --       -- zindex = 1, -- determines if window is on top or below other floating windows
  --     },
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  --   keys = {
  --     {
  --       "<leader>cc",
  --       "<cmd>CopilotChatToggle<cr>",
  --       desc = 'Copilot Chat Toggle'
  --     }
  --   },
  -- },

}
