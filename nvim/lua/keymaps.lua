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
-- gra => vim.lsp.buf.code_action() -- fzf
-- grr => vim.lsp.buf.references() -- fzf
-- gri => vim.lsp.buf.implementation() -- fzf
-- grt => vim.lsp.buf.type_definition() -- fzf
-- gO  => vim.lsp.buf.document_symbol() -- fzf

