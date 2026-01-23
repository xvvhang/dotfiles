return {
  'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  build = function() vim.cmd('TSUpdate') end,
  config = function()
    require('nvim-treesitter').setup({
      auto_install = true,
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        }
      },
    })
  end,
  event = { 'BufEnter' }
}
