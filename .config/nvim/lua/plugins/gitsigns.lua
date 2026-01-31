return {
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', 'ghs', gitsigns.stage_hunk)
      map('n', 'ghr', gitsigns.reset_hunk)
      map('n', 'ghd', gitsigns.diffthis)
    end
  }
}
