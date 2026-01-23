return {
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
        },
        direction_priority = function()
          local ctx = require('blink.cmp').get_context()
          local item = require('blink.cmp').get_selected_item()
          if ctx == nil or item == nil then return { 's', 'n' } end

          local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
          local is_multi_line = item_text:find('\n') ~= nil

          -- after showing the menu upwards, we want to maintain that direction
          -- until we re-open the menu, so store the context id in a global variable
          if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
            vim.g.blink_cmp_upwards_ctx_id = ctx.id
            return { 'n', 's' }
          end
          return { 's', 'n' }
        end,
      },
      documentation = {
        auto_show = true,
        window = { border = 'none' }
      },
      ghost_text = { enabled = true }
    },
    keymap = {
      preset = 'super-tab',
    },
    signature = {
      enabled = true,
      window = { border = 'none' }
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
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      }
    }
  },
  event = { 'InsertEnter' }
}
