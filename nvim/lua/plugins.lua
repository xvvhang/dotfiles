-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = 'themes.current' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'branch',
            icon = { '', color = { fg='#f14c28' } }
          },
          {
            'filetype',
            colored = true,
            icon_only = true,
            padding = { left = 1, right = 0 }
          },
          {
            'filename',
            path = 1,
            padding = { left = 0, right = 1 },
            symbols = {
              unnamed = ' [No Name]',
              newfile = ' [New]',
            }
          },
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' '
            }
          },
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' '
            }
          }
        },
        lualine_x = {
          'searchcount',
          'selectioncount',
          {
            'location',
            padding = { left = 1, right = 0 }
          }
        },
        lualine_y = {},
        lualine_z = {}
      }
    }
  },
  {
    'echasnovski/mini.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    version = '*',
    config = function()
      require('ts_context_commentstring').setup({ enable_autocmd = false })

      -- Text Editing
      require('mini.ai').setup()
      require('mini.comment').setup({
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
          end
        }
      })
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      require('mini.surround').setup()

      -- General Workflow
      require('mini.bracketed').setup()
      require('mini.bufremove').setup()
      require('mini.diff').setup({
        view = {
          style = 'sign',
          signs = {
            add = '┃',
            change = '┃',
            delete = '_'
          }
        },
        mappings = {
          apply = 'gs',
          reset = 'gu',
          textobject = 'gh'
        }
      })
      require('mini.git').setup()
      require('mini.jump').setup()
      require('mini.jump2d').setup()

      -- Appearance
      require('mini.cursorword').setup()
      require('mini.hipatterns').setup({
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color()
        }
      })
      require('mini.indentscope').setup({
        draw = {
          delay = 50,
          animation = require('mini.indentscope').gen_animation.none()
        },
        symbol = '│'
      })
      require('mini.trailspace').setup()
    end,
    event = { 'BufEnter' }
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      'borderless-full',
      winopts = {
        height = 0.8,
        width = 0.6,
        row = 0.5,
        backdrop = 100,
        title_flags = false,
        preview = {
          scrollbar = false
        }
      },
      hls = {
        title          = 'IncSearch',
        border         = 'NormalFloat',
        preview_title  = 'IncSearch',
        preview_border = 'NormalFloat',
      },
      fzf_colors = {
        ["gutter"] = { "bg", "NormalFloat" },
        ["bg"]     = { "bg", "NormalFloat" },
        ["bg+"]    = { "bg", "NormalFloat" },
        ["fg+"]    = { "fg", "NormalFloat" },
      }
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
      { 'gl', ':FzfLua lsp_finder<CR>' },
      { 'ge', ':FzfLua diagnostics_document<CR>' },
      { 'ga', ':FzfLua lsp_code_actions<CR>' },
      { 'gr', ':FzfLua lsp_references<CR>' },
      { 'gi', ':FzfLua lsp_implementations<CR>' },
      { 'gt', ':FzfLua lsp_typedefs<CR>' },
      { 'go', ':FzfLua lsp_document_symbols<CR>' },
    }
  },
  {
    'mikavilpas/yazi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      floating_window_scaling_factor = 0.8,
      yazi_floating_window_border = 'none',
      keymaps = {
        open_file_in_horizontal_split = '<C-s>'
      }
    },
    config = function()
      vim.api.nvim_set_hl(0, 'YaziFloat', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'YaziFloatBorder', { link = 'FloatBorder' })
    end,
    cmd = { 'Yazi' },
    keys = {
      { '<leader>o', ':Yazi<CR>' }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    build = function() vim.cmd('TSUpdate') end,
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true },
        incremental_selection = { enable = true },
      })
    end,
    event = { 'BufEnter' }
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        border = 'none',
        backdrop = 100,
        width = 0.6,
        height = 0.8
      }
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
    cmd = { 'Mason' },
    event = { 'BufEnter' }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
      '/vue-language-server' .. '/node_modules/@vue/language-server'

      vim.lsp.config['emmet_language_server'] = {
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
      vim.lsp.config['lua_ls'] = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
      vim.lsp.config['vue_ls'] = {
        on_init = function(client)
          client.handlers['tsserver/request'] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
            if #clients == 0 then
              vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
              return
            end
            local ts_client = clients[1]

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
              local response_data = { { id, response } }
              ---@diagnostic disable-next-line: param-type-mismatch
              client:notify('tsserver/response', response_data)
            end)
          end
        end
      }
      vim.lsp.config['vtsls'] = {
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
      vim.lsp.enable({
        'astro',
        'cssls',
        'emmet_language_server',
        'html',
        'jsonls',
        'lua_ls',
        'tailwindcss',
        'vue_ls',
        'vtsls',
        'yamlls'
      })
    end,
    event = { 'BufEnter' }
  },
  {
    'zbirenbaum/copilot.lua',
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false }
    },
    event = { 'InsertEnter' }
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'fang2hou/blink-copilot'
    },
    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true
          }
        },
        menu = {
          border = 'none',
          draw = {
            gap = 1,
            treesitter = { 'lsp' },
            columns = {
              { "kind" },
              { "label", "label_description", gap = 1 },
              { "source_name" }
            }
          }
        },
        documentation = {
          auto_show = true,
          window = { border = 'none' }
        }
      },
      signature = {
        enabled = true,
        window = { border = 'none' }
      },
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
      },
      sources = {
        default = {
          'copilot',
          'lsp',
          'path',
          'snippets',
          'buffer'
        },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true
          },
        },
        per_filetype = {
          codecompanion = { 'codecompanion' }
        }
      }
    },
    event = { 'InsertEnter' }
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
    cmd = {
      'CodeCompanion',
      'CodeCompanionAction',
      'CodeCompanionChat',
      'CodeCompanionCmd'
    },
    keys = {
      { '<leader>l', ':CodeCompanionChat<CR>' }
    }
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { 'markdown', 'codecompanion' },
      completions = { blink = { enabled = true } },
    },
    ft = { 'markdown', 'codecompanion' }
  }
}

require("lazy").setup({
  spec = plugins,
  ui = { backdrop = 100 },
  checker = { enabled = true }
})

