require("yatline"):setup({
  section_separator = { open = '', close = '' },
  part_separator = { open = '', close = '' },

  style_c = { bg="black" },

  show_background = true,
  display_header_line = false,

  status_line = {
    left = {
      section_a = {},
      section_b = {},
      section_c = {
        { type = "string", custom = false, name = "hovered_path" }
      }
    },
    right = {
      section_a = {},
      section_b = {},
      section_c = {
        { type = "coloreds", custom = false, name = "permissions" },
        { type = "string", custom = false, name = "hovered_size" },
      }
    }
  },
})

