return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        numbers = 'ordinal',
        indicator = { style = 'none' },
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        show_buffer_close_icons = false,
        show_close_icon = false
      }
    })
  end,
  lazy = false,
  keys = {
    { '<leader>1', ':BufferLineGoToBuffer 1<CR>' },
    { '<leader>2', ':BufferLineGoToBuffer 2<CR>' },
    { '<leader>3', ':BufferLineGoToBuffer 3<CR>' },
    { '<leader>4', ':BufferLineGoToBuffer 4<CR>' },
    { '<leader>5', ':BufferLineGoToBuffer 5<CR>' },
    { '<leader>6', ':BufferLineGoToBuffer 6<CR>' },
    { '<leader>7', ':BufferLineGoToBuffer 7<CR>' },
    { '<leader>8', ':BufferLineGoToBuffer 8<CR>' },
    { '<leader>9', ':BufferLineGoToBuffer 9<CR>' },
    { '<leader>p', ':BufferLinePick<CR>' },
  }
}
