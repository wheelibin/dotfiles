local neotest = require('neotest')

-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message =
          diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)


neotest.setup({
  -- log_level = vim.log.levels.DEBUG,
  adapters = {
    require("neotest-go")
  }
})


local legendary = require('legendary')
local legendary_toolbox = require('legendary.toolbox')

legendary.keymaps({
  {
    '<leader>tn', neotest.run.run, description = 'Test nearest'
  },
  {
    '<leader>to', legendary_toolbox.lazy(neotest.output.open, { short = true }), description = 'Test Output'
  },
  {
    '<leader>ts', neotest.summary.toggle, description = 'Test status'
  }
})
