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
  configNamespace = 'typescript'
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
    typescript = {
      tsserver = {
        maxTsServerMemory = 8192
      },
      preferences = {
        includePackageJsonAutoImports = false
      }
    }
  },
  filetypes = tserver_filetypes,
  -- NOTE: https://github.com/vuejs/language-tools/wiki/Neovim
  on_attach = function(client)
    local existing_capabilities = client.server_capabilities
    if vim.bo.filetype == 'vue' then
      existing_capabilities.semanticTokensProvider.full = false
    else
      existing_capabilities.semanticTokensProvider.full = true
    end
  end
}

local vue_config = {
  -- NOTE: https://github.com/vuejs/language-tools/wiki/Neovim
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
      local clients = {}

      vim.list_extend(clients, vtsls_clients)

      if #clients == 0 then
        vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local unpack = table.unpack or unpack
      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        -- TODO: handle error or response nil here, e.g. logging
        -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
        local response_data = { { id, response } }

        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify('tsserver/response', response_data)
      end)
    end
  end,
}

return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config['lua_ls'] = lua_config
    vim.lsp.config['vtsls'] = vts_config
    vim.lsp.config['vue_ls'] = vue_config

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
