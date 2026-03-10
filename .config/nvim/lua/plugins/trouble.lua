return {
  'folke/trouble.nvim',
  opts = {
    auto_close = true,
    icons = {
      indent = {
        top           = "│ ",
        middle        = "├╴",
        last          = "└╴",
        fold_open     = " ",
        fold_closed   = " ",
      },
      folder_closed   = " ",
      folder_open     = " ",
      kinds = {
        Array         = " ",
        Boolean       = " ",
        Class         = " ",
        Constant      = " ",
        Constructor   = " ",
        Enum          = " ",
        EnumMember    = " ",
        Event         = " ",
        Field         = " ",
        File          = " ",
        Function      = " ",
        Interface     = " ",
        Key           = " ",
        Method        = " ",
        Module        = " ",
        Namespace     = " ",
        Null          = " ",
        Number        = " ",
        Object        = " ",
        Operator      = " ",
        Package       = " ",
        Property      = " ",
        String        = " ",
        Struct        = " ",
        TypeParameter = " ",
        Variable      = " ",
      },
    }
  },
  config = function(_, opts)
    require('trouble').setup(opts)
    local config = require("fzf-lua.config")
    local actions = require("trouble.sources.fzf").actions
    config.defaults.actions.files["ctrl-t"] = actions.open
  end,
  lazy = false,
  cmd = 'Trouble',
  keys = {
    { 'gd', ':Trouble lsp_definitions<CR>' },
    { 'grr', ':Trouble lsp_references<CR>' },
    { 'gra', ':Trouble lsp_command<CR>' },
    { 'gO', ':Trouble lsp_document_symbols<CR>' },
  }
}

