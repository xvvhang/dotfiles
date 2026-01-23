return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    'fzf-native',
    winopts = {
      height = 0.8,
      width = 0.8,
      row = 0.5,
      backdrop = 100,
      fullscreen = true,
      border = "none",
      preview = {
        border = "none",
        scrollbar = "scrollbar",
      }
    },
    fzf_colors = {
      true,
      ["gutter"] = { "bg", "PmenuSbar" },
      ["bg"] = { "bg", "NormalFloat" }
    },
    hls = {
      preview_normal = "NormalFloat",
    }
  },
  config = function(_, opts)
    require('fzf-lua').register_ui_select()
    require('fzf-lua').setup(opts)
  end,
  lazy = false,
  cmd = { 'FzfLua' },
  keys = {
    { '<leader>/', ':FzfLua<CR>' },
    { '<leader>b', ':FzfLua buffers<CR>' },
    { '<leader>f', ':FzfLua files<CR>' },
    { '<leader>s', ':FzfLua live_grep<CR>' },
    { '<leader>g', ':FzfLua git_status<CR>' },
    { '<leader>h', ':FzfLua git_hunks<CR>' },
    { 'grf', ':FzfLua lsp_finder<CR>' },
    { 'gd', ':FzfLua lsp_definitions<CR>' },
    { 'gra', ':FzfLua lsp_code_actions<CR>' },
    { 'grr', ':FzfLua lsp_references<CR>' },
    { 'gri', ':FzfLua lsp_implementations<CR>' },
    { 'grt', ':FzfLua lsp_typedefs<CR>' },
    { 'gO', ':FzfLua lsp_document_symbols<CR>' },
  }
}
