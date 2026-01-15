return {
  'mikavilpas/yazi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    open_for_directories = false,
    yazi_floating_window_border = 'none',
    floating_window_scaling_factor = 0.8,
    highlight_groups = {
      hovered_buffer = { link = 'Normal' }
    },
    keymaps = {
      open_file_in_horizontal_split = '<C-s>'
    },
    highlight_hovered_buffers_in_same_directory = false
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, 'YaziFloat', { link = 'NormalFloat', default = true })
    require('yazi').setup(opts)
  end,
  cmd = { 'Yazi' },
  keys = {
    { '<leader>e', ':Yazi<CR>' }
  }
}
