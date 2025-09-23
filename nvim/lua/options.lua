vim.opt.cmdheight = 0
vim.opt.completeopt = "menu"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smoothscroll = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.winborder = "none"
vim.opt.wrap = true

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
    }
  },
  float = {
    severity_sort = true,
    source = true
  },
  severity_sort = true
})

vim.g.loaded_node_provider = 0

vim.api.nvim_set_hl(0, "MsgArea", { link = "StatusLine" })
