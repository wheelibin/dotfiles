local legendary = require('legendary')

vim.g.coc_global_extensions = {
  'coc-tsserver',
  'coc-json',
  'coc-html',
  'coc-css',
  'coc-prettier',
  'coc-eslint',
  'coc-sumneko-lua',
  'coc-pairs'
}

local expr_opts = { silent = true, expr = true, noremap = true }

legendary.bind_keymaps({
  { '<C-space>',
    ':call CocAction("doHover")<cr>',
    description = 'Code docs'
  },
  { '[d', "<Plug>(coc-diagnostic-prev)", description = 'Prev Diagnostics message' },
  { ']d', "<Plug>(coc-diagnostic-next)", description = 'Next Diagnostics message' },
  { '<cr>', [[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"]], mode = 'i', opts = expr_opts},
  { '<Tab>', [[pumvisible() ? coc#pum#next(1) : "\<Tab>"]], mode='i', opts = expr_opts },
  { '<S-Tab>', [[pumvisible() ? coc#pum#prev(1) : "\<S-Tab>"]], mode='i', opts = expr_opts},

  -- trigger completion
  { '<C-space>', [[coc#refresh()]], mode = 'i', opts = expr_opts},

  -- code navigation
  { 'gd', "<Plug>(coc-definition)"},
  { 'gs', ":call CocAction('jumpDefinition', 'vsplit') <CR>"},
  { 'gi', "<Plug>(coc-definition)"},
  { 'gd', "<Plug>(coc-implementation)"},
  { 'gr', "<Plug>(coc-references)"},
  { '<leader>ca', '<Plug>(coc-codeaction)'}

})

-- AutoCmds
-- highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_autocmd("CursorHold", { pattern = '*', command = [[call CocActionAsync("highlight")]] })

-- override some highlight groups
local set_colours = function()
  vim.cmd("hi! link CocSearch DiagnosticHint")
end
vim.api.nvim_create_autocmd("ColorScheme", { pattern = '*', callback = set_colours })

-- highlight overrides
-- autocmd ColorScheme * call Highlight()
--
-- function! Highlight() abort
--   hi Conceal ctermfg=239 guifg=#504945
--   hi CocSearch ctermfg=12 guifg=#18A3FF
-- endfunction
--
