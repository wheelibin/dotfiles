require('neogit').setup()

local map = require('utils').map

 map('n', '<Leader>g', '<cmd>lua require("neogit").open({ kind = "vsplit" })<cr>')
