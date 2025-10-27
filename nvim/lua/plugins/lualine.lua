local branch = {
  'branch',
  icon = { '', color = { fg = '#d85f14' } }
}

local filetype = {
  'filetype',
  colored = true,
  icon_only = true,
  padding = { left = 1, right = 0 }
}

local filename = {
  'filename',
  path = 1,
  symbols = {
    unnamed = ' [No Name]',
    newfile = ' [New]',
  },
  padding = { left = 0, right = 1 }
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_lsp' },
  symbols = {
    error = ' ',
    warn = ' ',
    info = ' ',
    hint = ' '
  }
}

local diff = {
  'diff',
  symbols = {
    added = ' ',
    modified = ' ',
    removed = ' '
  }
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine'
  },
  opts = {
    options = {
      disabled_filetypes = {
        statusline = { "opencode", "opencode_output" }
      },
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {
        branch,
        filetype,
        filename,
        diagnostics,
        diff
      },
      lualine_x = {
        'copilot',
        'searchcount',
        'selectioncount',
        'location',
      }
    },
    extensions = {
      'fzf',
      'lazy',
      'mason',
      'quickfix',
    }
  }
}
