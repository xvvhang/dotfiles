return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    'fzf-native',
    winopts = {
      height = 0.65,
      width = 0.65,
      row = 0.5,
      backdrop = 100,
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
    { 'ga', ':FzfLua lsp_code_actions<CR>' },
    { 'gr', ':FzfLua lsp_references<CR>' },
    { 'gi', ':FzfLua lsp_implementations<CR>' },
    { 'gt', ':FzfLua lsp_typedefs<CR>' },
    { 'gs', ':FzfLua lsp_document_symbols<CR>' },
  }
}
