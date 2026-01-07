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

    -- Filter out vtsls diagnostics for Vue files
    -- This prevents template/style errors while keeping script diagnostics from vue_ls
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('VueLspConfig', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local bufnr = args.buf
        -- When vtsls attaches to a vue file, filter its diagnostics
        if client and client.name == 'vtsls' and vim.bo[bufnr].filetype == 'vue' then
          -- Set up diagnostic filtering for this buffer
          vim.diagnostic.config({
            virtual_text = {
              source = 'if_many',
            },
          }, vim.lsp.diagnostic.get_namespace(client.id))

          -- Create an autocommand to clear vtsls diagnostics in vue files
          vim.api.nvim_create_autocmd('DiagnosticChanged', {
            buffer = bufnr,
            callback = function()
              -- Get all diagnostics for this buffer
              local diagnostics = vim.diagnostic.get(bufnr)
              local filtered = {}

              -- Keep only non-vtsls diagnostics
              for _, diag in ipairs(diagnostics) do
                local namespace = vim.diagnostic.get_namespace(diag.namespace)
                if namespace and namespace.name and not namespace.name:match('vtsls') then
                  table.insert(filtered, diag)
                end
              end

              -- Clear vtsls diagnostics namespace for this buffer
              vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(client.id), bufnr)
            end,
          })
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
