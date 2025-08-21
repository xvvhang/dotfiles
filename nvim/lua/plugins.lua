-- Put this at the top of 'init.lua'
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local deps = require('mini.deps')

deps.add({
  source = 'echasnovski/mini.nvim',
  depends = { 'JoosepAlviste/nvim-ts-context-commentstring' }
})

deps.add({
  source = 'ibhagwan/fzf-lua',
  depends = { 'nvim-tree/nvim-web-devicons' }
})

deps.add({
  source = 'mikavilpas/yazi.nvim',
  depends = { 'nvim-lua/plenary.nvim' }
})

deps.add({
  source = 'lewis6991/gitsigns.nvim'
})

deps.add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end }
})

deps.add({
  source = 'neovim/nvim-lspconfig',
  depends = { 'williamboman/mason.nvim' }
})

deps.add({
  source = 'saghen/blink.cmp',
  checkout = 'v1.6.0',
  depends = { 'rafamadriz/friendly-snippets' }
})

deps.add({
  source = 'CopilotC-Nvim/CopilotChat.nvim',
  depends = {
    'zbirenbaum/copilot.lua',
    'nvim-lua/plenary.nvim',
    'AndreM222/copilot-lualine'
  },
  hooks = { post_checkout = function() vim.cmd('make tiktoken') end }
})

deps.add({
  source = 'nvim-lualine/lualine.nvim',
  depends = { 'nvim-tree/nvim-web-devicons' }
})

deps.add({
  source = 'mrjones2014/smart-splits.nvim'
})

deps.add({
  source = 'folke/tokyonight.nvim'
})

deps.add({
  source = 'ellisonleao/gruvbox.nvim'
})

require('themes.current')

deps.now(function()
  require('lualine').setup({
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
  })
end)

deps.later(function()
  require('mini.deps').setup()
  require('mini.ai').setup()
  require('ts_context_commentstring').setup {
    enable_autocmd = false,
  }
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
  require('mini.bracketed').setup()
  require('mini.bufremove').setup()
  require('mini.jump').setup()
  require('mini.jump2d').setup()
  require('mini.cursorword').setup()
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
      hex_color = hipatterns.gen_highlighter.hex_color()
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
end)

deps.now(function()
  require('fzf-lua').setup({
    'borderless-full',
    winopts = {
      height = 0.8,
      width = 0.6,
      row = 0.5,
      backdrop = 100,
      title_pos = 'center',
      title_flags = false,
      preview = {
        title_pos = 'center'
      }
    }
  })
  require('fzf-lua').register_ui_select()
end)

deps.now(function()
  require('yazi').setup({
    floating_window_scaling_factor = 0.8,
    yazi_floating_window_border = 'none',
    open_file_in_horizontal_split = '<C-s>'
  })
  vim.api.nvim_set_hl(0, 'YaziFloat', { link = 'NormalFloat' })
  vim.api.nvim_set_hl(0, 'YaziFloatBorder', { link = 'FloatBorder' })
end)

deps.later(function()
  require('gitsigns').setup({
    signcolumn = false,
    numhl = true,
    linehl = true,
    current_line_blame = true
  })
end)

deps.later(function()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = { enable = true },
    incremental_selection = { enable = true },
  })
end)

deps.later(function()
  require('mason').setup({
    ui = {
      border = 'none',
      backdrop = 100,
      width = 0.6,
      height = 0.8
    }
  })
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
end)

deps.later(function()
  require('blink.cmp').setup({
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
        window = { border = 'none' }
      }
    },
    signature = {
      enabled = true,
      window = { border = 'none' }
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
  })
end)

deps.later(function()
  require('CopilotChat').setup({
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
      border = 'none',
      width = 0.5,
      title = ' Copilot Chat '
    },
    show_help = false
  })
end)
