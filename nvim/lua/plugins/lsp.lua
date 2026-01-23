local lua_config = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

local vue_typescript_plugin_path = vim.fn.stdpath("data") ..
  "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
local tserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_typescript_plugin_path,
  languages = tserver_filetypes,
  configNamespace = 'typescript',
}

local vts_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tserver_filetypes
}

return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config['lua_ls'] = lua_config
    vim.lsp.config['vtsls'] = vts_config

    vim.lsp.enable({
      'bashls',
      'copilot',
      'cssls',
      'dockerls',
      'emmet_language_server',
      'fish_lsp',
      'gopls',
      'html',
      'jsonls',
      'lua_ls',
      'oxlint',
      'rust-analyzer',
      'tailwindcss',
      'vtsls',
      'vue_ls',
      'yamlls',
      'zls'
    })
  end,
  event = { 'BufReadPre', 'BufNewFile' }
}
