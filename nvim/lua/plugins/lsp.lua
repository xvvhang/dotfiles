local lua_config = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local tserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
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
  filetypes = { 'vue' },
}
local ts_config = {
  init_options = {
    plugins = {
      vue_plugin,
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
      'tsgo',
      'vtsls',
      'vue_ls',
      'yamlls',
    })
  end,
  event = { 'BufReadPre', 'BufNewFile' }
}
