local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
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
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup()
      require('mini.comment').setup({
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring () or vim.bo.commentstring
          end
        }
      })
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      require('mini.surround').setup()
      require('mini.bracketed').setup({
        diagnostic = {
          options = {
            severity = {
              vim.diagnostic.severity.ERROR,
              vim.diagnostic.severity.WARN
            }
          }
        }
      })
      require('mini.bufremove').setup()
      require('mini.jump').setup()
      require('mini.jump2d').setup({
        view = { dim = true }
      })
      require('mini.sessions').setup()
      require('mini.cursorword').setup()
      require('mini.hipatterns').setup({
        highlighters = {
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
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
    lazy = false,
    priority = 800,
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      winopts = {
        height = 0.8,
        width = 0.7,
        row = 0.5,
        backdrop = 100,
        title_pos = 'left',
        title_flags = false,
        preview = {
          title_pos = 'left',
          horizontal = 'right:50%',
          scrollbar = false,
        }
      },
      hls = {
        normal = 'NormalFloat',
        border = 'FloatBorder',
        title = 'FloatTitle',
        preview_normal = 'NormalFloat',
        preview_border = 'FloatBorder',
        preview_title = 'FloatTitle',
      }
    },
    config = function(_, otps)
      require('fzf-lua').setup(otps)
      require('fzf-lua').register_ui_select()
    end,
    cmd = { 'FzfLua' },
    keys = {
      { '<leader>b', ':FzfLua buffers<CR>' },
      { '<leader>f', ':FzfLua files<CR>' },
      { '<leader>s', ':FzfLua live_grep<CR>' },
      { '<leader>g', ':FzfLua git_status<CR>' },
      { '<leader>h', ':FzfLua git_hunks<CR>' },
      { '<leader>d', ':FzfLua lsp_workspace_diagnostics<CR>' },
      { '<leader>.', ':FzfLua resume<CR>' },
      { '<leader>/', ':FzfLua<CR>' },
    }
  },
  {
    'mikavilpas/yazi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      floating_window_scaling_factor = 0.8,
      open_file_in_horizontal_split = '<C-s>'
    },
    cmd = { 'Yazi' },
    keys = {
      { '<leader>o', ':Yazi<CR>' }
    }
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true
          }
        },
        menu = {
          border = 'rounded',
          draw = {
            gap = 2,
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
          window = { border = 'rounded' }
        }
      },
      signature = {
        enabled = true,
        window = { border = 'rounded' }
      },
      keymap = { preset = 'enter' },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
        }
      }
    },
    event = "InsertEnter"
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signcolumn = false,
      numhl = true,
      linehl = true,
      current_line_blame = true,
      on_attach = function()
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({']h', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)
        vim.keymap.set('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({'[h', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)
      end
    },
    cmd = { 'Gitsigns' },
    keys = {
      { 'gu', ':Gitsigns reset_hunk<CR>' },
      { 'gh', ':Gitsigns preview_hunk_inline<CR>' },
      { '<leader>h', ':Gitsigns preview_hunk_inline<CR>' }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    build = function() vim.cmd('TSUpdate') end,
    opts = {
      ensure_installed = { "lua" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      fold = { enable = true }
    }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason').setup({
        ui = {
          border = 'none',
          width = 1,
          height = 1
        }
      })
      local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
      '/vue-language-server' .. '/node_modules/@vue/language-server'

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
                local response_data = { { id, r.body } }
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
        'cssls',
        'emmet_language_server',
        'gopls',
        'html',
        'jsonls',
        'lua_ls',
        'pyright',
        'tailwindcss',
        'vue_ls',
        'vtsls',
        'yamlls'
      })
    end,
    event = {
      'BufReadPre',
      'BufNewFile',
    }
  },
  {
    'zbirenbaum/copilot.lua',
    opts = {
      panel = { enabled = false },
      suggestion = {
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = '<TAB>'
        }
      }
    },
    event = "InsertEnter"
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
      'AndreM222/copilot-lualine'
    },
    build = 'make tiktoken',
    opts = {
      keymaps = {
        accept = '<TAB>',
        accept_word = '<C-Tab>',
        accept_line = '<C-S-Tab>',
        next = '<C-n>',
        prev = '<C-p>',
        close = '<C-c>'
      },
      window = {
        layout = 'horizontal',
        border = 'rounded',
        width = 0.5,
        height = 0.4,
        title = ' Copilot Chat '
      },
      show_help = false
    },
    cmd = { 'CopilotChat', 'CopilotChatToggle' },
    keys = {
      { '<leader>k', ':CopilotChatToggle<CR>' }
    }
  },
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
          {
            'copilot',
            symbols = {
              spinners = 'dots'
            },
            show_colors = false,
            show_loading = true
          },
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
    },
    lazy = false,
    priority = 900
  },
  {
    'keaising/im-select.nvim',
    lazy = false,
    priority = 100
  },
  {
    'zk-org/zk-nvim',
    cmd = { 'ZkNotes' },
    keys = {
      { '<leader>z', ':ZkNotes<CR>' }
    }
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup()
      vim.cmd([[colorscheme tokyonight-night]])
    end
  }
}

require('lazy').setup(plugins, {
  ui = {
    size = { width = 0.5, height = 0.8 },
    border = 'rounded',
    title = ' Lazy ',
    title_pos = 'left',
    backdrop = 100
  }
})

