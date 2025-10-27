require("yatline"):setup({
  show_background = false,
  section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

  header_line = {
    left = {
      section_a = {
        {type = "line", custom = false, name = "tabs", params = {"left"}},
      },
      section_b = {},
      section_c = {}
    },
    right = {
      section_a = {},
      section_b = {},
      section_c = {}
    }
  },
  status_line = {
    left = {
      section_a = {},
      section_b = {
        {type = "string", custom = false, name = "hovered_path"},
      },
      section_c = {}
    },
    right = {
      section_a = {},
      section_b = {
        {type = "string", custom = false, name = "hovered_size"},
        {type = "coloreds", custom = false, name = "permissions"},
        {type = "coloreds", custom = false, name = "count"},
      },
      section_c = {}
    }
  },
})
