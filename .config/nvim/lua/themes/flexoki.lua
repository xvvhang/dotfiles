return {
  'kepano/flexoki-neovim',
  name = 'flexoki',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme flexoki')
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
  end
}
