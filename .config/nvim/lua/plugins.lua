--- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = 'themes.current' },
  require('plugins.lualine'),
  require('plugins.mini'),
  require('plugins.fzf'),
  require('plugins.yazi'),
  require('plugins.trouble'),
  require('plugins.gitsigns'),
  require('plugins.treesitter'),
  require('plugins.mason'),
  require('plugins.lsp'),
  require('plugins.blink'),
  require('plugins.copilot'),
  require('plugins.opencode'),
  require('plugins.markdown'),
  require('plugins.split'),
}

require("lazy").setup(plugins, {
  ui = {
    size = { width = 0.8, height = 0.8 },
    backdrop = 100
  },
  checker = { enabled = true, frequency = 604800 }
})

