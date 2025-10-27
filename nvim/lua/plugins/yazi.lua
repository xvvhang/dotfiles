return {
  'mikavilpas/yazi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    floating_window_scaling_factor = 0.6,
    yazi_floating_window_border = 'none',
    keymaps = {
      open_file_in_horizontal_split = '<C-s>'
    }
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, 'YaziFloat', { link = 'NormalFloat', default = true })
    require('yazi').setup(opts)
  end,
  cmd = { 'Yazi' },
  keys = {
    { '<leader>y', ':Yazi<CR>' }
  }
}
