return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme gruvbox')
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
  end
}
