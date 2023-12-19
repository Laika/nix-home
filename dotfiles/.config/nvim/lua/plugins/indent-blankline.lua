return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  opts = {
    indent = {
      char = "│",
      tab_char = ">",
    },
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
    },
  },
  main = "ibl",
}
