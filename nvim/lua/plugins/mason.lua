return {
  'mason-org/mason.nvim',
  opts = {
    ui = {
      border = 'none',
      backdrop = 100,
      width = 0.8,
      height = 0.8
    }
  },
  cmd = { 'Mason' },
  event = { 'BufEnter' }
}
