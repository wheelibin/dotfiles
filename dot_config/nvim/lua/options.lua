vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- disable word wrap
vim.o.wrap = false

-- Enable break indent
vim.o.breakindent = true

-- persistent undo history
vim.o.undofile = true

-- line numbers
vim.o.number = true
-- vim.o.relativenumber = true

-- sync clipboard between nvim and OS
vim.o.clipboard = 'unnamedplus'

-- search flags
vim.o.ignorecase = true
vim.o.smartcase = true

-- whitespace
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Decrease update time
-- vim.o.updatetime = 250

-- show sign column
vim.o.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- needed for colorizer
vim.o.termguicolors = true

-- enable the mouse in (a)ll modes
vim.o.mouse = 'a'

-- scroll offset
vim.o.scrolloff = 4

-- full line at cursor position
vim.o.cursorline = true

vim.o.swapfile = false

-- cursor not allowed in whitespace
vim.o.virtualedit = 'none'

-- hide the tildes showing end of buffer
vim.o.fcs = "eob: "

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false
-- vim.o.foldmethod = "indent"

-- vim.o.conceallevel = 1

vim.o.winborder = 'rounded'
