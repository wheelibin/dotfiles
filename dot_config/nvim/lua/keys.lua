local wk = require("which-key")

wk.register({
  -- buffer switching
  ["<leader>b"] = { name = "+Buffer" },
  ["<leader>bf"] = { [[:bn<cr>]], "Buffer Forward (next)" },
  ["<leader>bb"] = { [[:bp<cr>]], "Buffer Back (prev)" },

  --- copy paste to system clipboard
  ["<Leader>y"] = { '"+y', "Copy to system clipboard", mode = "v" },
  ["<Leader>p"] = { '"+p', "Paste from system clipboard" },
  ["<Leader>P"] = { '"+P', "Paste from system clipboard before" },
})

local map = require('utils').map

-- faster window navigation
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

-- window resizing
map("n", "<C-M-S-j>", ':resize +2<CR>')
map("n", "<C-M-S-k>", ':resize -2<CR>')
map("n", "<C-M-S-l>", ':vertical resize +2<CR>')
map("n", "<C-M-S-h>", ':vertical resize -2<CR>')

--- move line in normal, insert and visual mode
map("n", "<C-j>", ":m .+1<CR>==")
map("n", "<C-k>", ":m .-2<CR>==")
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

