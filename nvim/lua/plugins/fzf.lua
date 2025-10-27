return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    'default-prompt',
    winopts = {
      height = 0.6,
      width = 0.6,
      row = 0.5,
      backdrop = 100,
      border = "none",
      preview = {
        border = "none",
        scrollbar = "scrollbar"
      }
    },
    fzf_colors = {
      ["gutter"] = { "bg", "PmenuSbar" },
    },
  },
  config = function(_, opts)
    require('fzf-lua').register_ui_select()
    require('fzf-lua').setup(opts)
  end,
  cmd = { 'FzfLua' },
  keys = {
    { '<leader>/', ':FzfLua<CR>' },
    { '<leader>b', ':FzfLua buffers<CR>' },
    { '<leader>f', ':FzfLua files<CR>' },
    { '<leader>s', ':FzfLua live_grep<CR>' },
    { '<leader>g', ':FzfLua git_status<CR>' },
    { '<leader>h', ':FzfLua git_hunks<CR>' },
    { 'gra', ':FzfLua lsp_code_actions<CR>' },
    { 'grr', ':FzfLua lsp_references<CR>' },
    { 'gri', ':FzfLua lsp_implementations<CR>' },
    { 'grt', ':FzfLua lsp_typedefs<CR>' },
    { 'g0', ':FzfLua lsp_document_symbols<CR>' },
  }
}
