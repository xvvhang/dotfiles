return {
  'zbirenbaum/copilot.lua',
  dependencies = {
    {
      'copilotlsp-nvim/copilot-lsp',
      config = function()
        vim.g.copilot_nes_debounce = 500
      end
    }
  },
  opts = {
    panel = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = false, -- use blink.cmp to accept suggestions
        next = false,
        previous = false,
        dismiss = false
      }
    },
    nes = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept_and_goto = '<Tab>',
        accept = false,
        dismiss = '<Esc>'
      }
    }
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
    require('copilot').setup(opts)
  end,
  event = 'InsertEnter',
  cmd = 'Copilot'
}
