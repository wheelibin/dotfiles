local map = require('utils').map

-- easier buffer switching
map('n', '<Leader>bf', [[:bn<cr>]])
map('n', '<Leader>bb', [[:bp<cr>]])

--- faster window navigation
map("n", "<M-h>", ":wincmd h<CR>")
map("n", "<M-j>", ":wincmd j<CR>")
map("n", "<M-k>", ":wincmd k<CR>")
map("n", "<M-l>", ":wincmd l<CR>")
map("n", "<M-r>", ":wincmd r<CR>")
map("n", "<M-q>", ":wincmd q<CR>")

--- faster window creation
map("n", "<M-S-h>", ":wincmd v<CR>:wincmd h<CR>")
map("n", "<M-S-j>", ":wincmd s<CR>")
map("n", "<M-S-k>", ":wincmd s<CR>:wincmd k<CR>")
map("n", "<M-S-l>", ":wincmd v<CR>")

--- copy paste to system clipboard
map("v", "<Leader>y", '"+y')
map("n", "<Leader>p", '"+p')
map("n", "<Leader>P", '"+P')

--- move line in normal, insert and visual mode
map("n", "<C-j>", ":m .+1<CR>==")
map("n", "<C-k>", ":m .-2<CR>==")
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

