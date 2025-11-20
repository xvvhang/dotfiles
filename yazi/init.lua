require("full-border"):setup()
require("yatline"):setup({
  -- separators
  section_separator = { open = "", close = "" },
  part_separator = { open = "", close = "" },
  inverse_separator = { open = "", close = "" },

  -- sections
  style_a = {
    fg = "black",
    bg_mode = {
      normal = "gray",
      select = "lightyellow",
      un_set = "lightred"
    }
  },

  -- tabs
  tab_width = 0,

  -- background
  show_background = false,

  -- lines
  display_status_line = false,
  header_line = {
		left = {
			section_a = {},
			section_b = {},
			section_c = {
        {type = "line", custom = false, name = "tabs", params = {"left"}},
      }
		},
    right = {
			section_a = {
        {type = "string", custom = false, name = "cursor_position"},
      },
			section_b = {},
			section_c = {}
    }
  }
})
