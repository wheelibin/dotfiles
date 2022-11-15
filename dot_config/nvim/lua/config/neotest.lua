local neotest = require('neotest')

neotest.setup({
  adapters = { require('neotest-jest')({ jestCommand = 'npm run test:once --' }) },
  highlights = {
    dir = 'Green',
    failed = 'Red',
    namespace = 'Blue',
    passed = 'Green',
    running = 'Yellow'
  },
  icons = { running = '⟳', passed = '✔', failed = '✕' }
})

local legendary = require('legendary')
local helpers = require('legendary.helpers')

legendary.keymaps({
  { '<leader>tn', neotest.run.run, description = 'Test nearest' }, {
    '<leader>to',
    helpers.lazy(neotest.output.open, { short = true }),
    description = 'Test Output'
  }, { '<leader>ts', neotest.summary.toggle, description = 'Test status' }
})
