vim.g.mapleader = " "

vim.keymap.set('n', '<leader>c', ':close<CR>')
vim.keymap.set('n', '<leader>d', ':bdelete<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quitall<CR>')

-- default keymaps of vim.lsp.buf
-- gd  => vim.lsp.buf.definition()
-- K   => vim.lsp.buf.hover()
-- grn => vim.lsp.buf.rename()
-- C-s => vim.lsp.buf.signature_help()
-- gra => vim.lsp.buf.code_action()
-- grr => vim.lsp.buf.references()
-- gri => vim.lsp.buf.implementation()
-- grt => vim.lsp.buf.type_definition()
-- gO  => vim.lsp.buf.document_symbol()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gk', vim.lsp.buf.hover)
vim.keymap.set('n', 'gn', vim.lsp.buf.rename)

vim.keymap.set('n', '<leader>/', ':FzfLua<CR>')
vim.keymap.set('n', '<leader>.', ':FzfLua resume<CR>')
vim.keymap.set('n', '<leader>b', ':FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>f', ':FzfLua files<CR>')
vim.keymap.set('n', '<leader>s', ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>g', ':FzfLua git_status<CR>')
vim.keymap.set('n', '<leader>h', ':FzfLua git_hunks<CR>')
vim.keymap.set('n', 'gl', ':FzfLua lsp_finder<CR>')
vim.keymap.set('n', 'ge', ':FzfLua diagnostics_document<CR>')
vim.keymap.set('n', 'ga', ':FzfLua lsp_code_actions<CR>')
vim.keymap.set('n', 'gr', ':FzfLua lsp_references<CR>')
vim.keymap.set('n', 'gi', ':FzfLua lsp_implementations<CR>')
vim.keymap.set('n', 'gt', ':FzfLua lsp_typedefs<CR>')
vim.keymap.set('n', 'go', ':FzfLua lsp_document_symbols<CR>')

vim.keymap.set('n', '<leader>o', ':Yazi<CR>')

vim.keymap.set('n', '<leader>l', ':CodeCompanionChat<CR>')

vim.keymap.set('n', 'gho', function() MiniDiff.toggle_overlay() end)
