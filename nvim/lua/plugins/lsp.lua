-- Path to Vue language server installed via Mason
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

-- Configure vtsls with Vue TypeScript plugin
-- This enables TypeScript features in Vue files including goto definition
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
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true
          }
        }
      }
    }
  },
  -- For Vue files, disable some capabilities to avoid conflicts with vue_ls
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == 'vue' then
      -- Disable semantic tokens to let vue_ls handle them
      client.server_capabilities.semanticTokensProvider = nil
      -- Disable formatting to let vue_ls or other formatters handle it
      client.server_capabilities.documentFormattingProvider = nil
      client.server_capabilities.documentRangeFormattingProvider = nil
    end
  end
}

-- Vue language server configuration
-- Handles Vue-specific features including template to script navigation
local vue_config = {
  init_options = {
    typescript = {
      tsdk = ''  -- Auto-detected from node_modules
    }
  }
}

return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config['emmet_language_server'] = emmet_config
    vim.lsp.config['lua_ls'] = lua_config
    vim.lsp.config['vtsls'] = vts_config
    vim.lsp.config['vue_ls'] = vue_config

    -- Set highlight for Vue components
    vim.api.nvim_set_hl(0, '@lsp.type.component', { link = '@type' })

    -- Use timer to periodically clear vtsls diagnostics in Vue files
    -- This is the most reliable method to prevent template/style errors
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('VueLspConfig', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        if client and client.name == 'vtsls' and vim.bo[bufnr].filetype == 'vue' then
          -- Use a timer to continuously clear vtsls diagnostics
          -- Only clear when not in visual/select mode to avoid interfering with user operations
          local timer = vim.uv.new_timer()
          timer:start(100, 100, function()
            vim.schedule(function()
              -- Check if buffer is still valid
              if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= 'vue' then
                timer:stop()
                timer:close()
                return
              end

              -- Only clear diagnostics when not in visual/select/operator-pending mode
              local mode = vim.api.nvim_get_mode().mode
              if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' and mode ~= 's' and mode ~= 'S' and mode ~= '\19' and mode ~= 'no' then
                vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(client.id), bufnr)
              end
            end)
          end)
        end
      end,
    })

    vim.lsp.enable({
      'astro',
      'cssls',
      'emmet_language_server',
      'html',
      'gopls',
      'jsonls',
      'lua_ls',
      'rust-analyzer',
      'svelte',
      'tailwindcss',
      'vue_ls',
      'vtsls',
      'yamlls',
    })
  end,
  event = { 'BufEnter' }
}
