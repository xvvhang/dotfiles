return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  opts = {
    completion = {
      list = { selection = { preselect = true, auto_insert = true } },
      menu = {
        auto_show = true,
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
      },
      ghost_text = { enabled = false }
    },
    keymap = {
      preset = 'enter',
      ['<Tab>'] = {
        function()
          local copilot = require('copilot.suggestion')
          if (copilot.is_visible()) then
            return copilot.accept()
          end
        end,
        'fallback',
      },
    },
    signature = {
      enabled = true,
      window = { border = 'none' }
    },
    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer'
      }
    }
  },
  event = { 'InsertEnter' }
}
