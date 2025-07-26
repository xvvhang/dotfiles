vim.g.mapleader = " "

vim.keymap.set('n', '<leader>c', ':close<CR>')
vim.keymap.set('n', '<leader>x', ':bdelete<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quitall<CR>')

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gn', vim.lsp.buf.rename)
vim.keymap.set('n', "gk", vim.lsp.buf.hover)
vim.keymap.set('n', 'go', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gO')
