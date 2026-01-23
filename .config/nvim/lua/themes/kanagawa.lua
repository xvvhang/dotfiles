return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme kanagawa-dragon')
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
  end
}
