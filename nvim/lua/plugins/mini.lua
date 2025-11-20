local setup_commentstring = function()
  require('ts_context_commentstring').setup({ enable_autocmd = false })
end

local setup_mini = function()
  require('mini.ai').setup()
  require('mini.bracketed').setup()
  require('mini.bufremove').setup()
  require('mini.cursorword').setup()
  require('mini.jump').setup()
  require('mini.jump2d').setup()
  require('mini.pick').setup()
  require('mini.pairs').setup()
  require('mini.splitjoin').setup()
  require('mini.surround').setup()
  require('mini.trailspace').setup()

  local commentstring = require('ts_context_commentstring')
  require('mini.comment').setup({
    options = {
      custom_commentstring = function()
        return commentstring.calculate_commentstring() or vim.bo.commentstring
      end
    }
  })

  require('mini.git').setup()
  ---@diagnostic disable-next-line:undefined-global
  vim.keymap.set('n', 'gbl', function() MiniGit.show_at_cursor({ split = 'horizontal' }) end)

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
      apply = 'ga',
      reset = 'gu',
      textobject = 'gh'
    }
  })
  ---@diagnostic disable-next-line:undefined-global
  vim.keymap.set('n', 'gho', function() MiniDiff.toggle_overlay() end)

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
end

return {
  'echasnovski/mini.nvim',
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  version = '*',
  config = function()
    setup_commentstring()
    setup_mini()
  end,
  event = { 'BufEnter' }
}
