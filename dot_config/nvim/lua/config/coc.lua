local legendary = require('legendary')

vim.g.coc_global_extensions = {
  'coc-css',
  'coc-eslint',
  'coc-html',
  'coc-json',
  'coc-lists',
  'coc-markdownlint',
  'coc-pairs',
  'coc-prettier',
  'coc-pyright',
  'coc-snippets',
  'coc-stylua',
  'coc-sumneko-lua',
  'coc-swagger',
  'coc-tsserver',
  'coc-yaml',
}

local expr_opts = { silent = true, expr = true, noremap = true }

legendary.bind_keymaps({
  { '<C-space>',
    ':call CocAction("doHover")<cr>',
    description = 'Code docs'
  },
  { '[d', "<Plug>(coc-diagnostic-prev)", description = 'Prev Diagnostics message' },
  { ']d', "<Plug>(coc-diagnostic-next)", description = 'Next Diagnostics message' },
  -- { '<Tab>', [[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"]], mode = 'i', opts = expr_opts },
  { '<Tab>', [[pumvisible() ? coc#pum#next(1) : "\<Tab>"]], mode = 'i', opts = expr_opts },
  { '<S-Tab>', [[pumvisible() ? coc#pum#prev(1) : "\<S-Tab>"]], mode = 'i', opts = expr_opts },
  { '<CR>', [[pumvisible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], mode = 'i', opts = expr_opts },

  -- trigger completion
  { '<C-space>', [[coc#refresh()]], mode = 'i', opts = expr_opts },

  -- code navigation
  { 'gd', "<Plug>(coc-definition)" },
  { 'gs', ":call CocAction('jumpDefinition', 'vsplit') <CR>" },
  { 'gd', "<Plug>(coc-definition)" },
  { 'gi', "<Plug>(coc-implementation)" },
  { 'gr', "<Plug>(coc-references)" },
  { '<leader>ca', '<Plug>(coc-codeaction)' },
  { '<leader>f', ':call CocAction("format") <CR>' }
})

-- AutoCmds
-- highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_autocmd("CursorHold", { pattern = '*', command = [[call CocActionAsync("highlight")]] })

-- override some highlight groups
local set_colours = function()
  vim.cmd("hi! link CocSearch DiagnosticHint")
  vim.cmd("hi! link DiffAdd GitSignsAdd")
  vim.cmd("hi! link DiffChange GitSignsChange")
  vim.cmd("hi! link DiffDelete GitSignsDelete")
  
end
vim.api.nvim_create_autocmd("ColorScheme", { pattern = '*', callback = set_colours })
