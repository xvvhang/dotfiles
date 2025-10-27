return {
  'mason-org/mason.nvim',
  opts = {
    ui = {
      border = 'none',
      backdrop = 100,
      width = 0.6,
      height = 0.6
    }
  },
  cmd = { 'Mason' },
  event = { 'BufEnter' }
}
