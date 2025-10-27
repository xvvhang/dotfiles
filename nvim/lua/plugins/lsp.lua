local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
'/vue-language-server' .. '/node_modules/@vue/language-server'

local emmet_config = {
  filetypes = {
    "css",
    "html",
    "javascriptreact",
    "typescriptreact",
    "less",
    "sass",
    "scss",
    "astro",
    "vue"
  }
}

local lua_config = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

local vts_config = {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
            configNamespace = 'typescript'
          }
        }
      }
    }
  }
}

local vue_config = {
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
      if #clients == 0 then
        vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local param = table.unpack(result)
      local id, command, payload = table.unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        local response_data = { { id, response } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify('tsserver/response', response_data)
      end)
    end
  end
}

return {
  'neovim/nvim-lspconfig',
  config = function()

    vim.lsp.config['emmet_language_server'] = emmet_config
    vim.lsp.config['lua_ls'] = lua_config
    vim.lsp.config['vtsls'] = vts_config
    vim.lsp.config['vue_ls'] = vue_config
    vim.lsp.enable({
      'astro',
      'cssls',
      'emmet_language_server',
      'html',
      'gopls',
      'jsonls',
      'lua_ls',
      'svelte',
      'tailwindcss',
      'vue_ls',
      'vtsls',
      'yamlls',
      'copilot'
    })
  end,
  event = { 'BufEnter' }
}
