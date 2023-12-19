return {
  "phaazon/hop.nvim",
  lazy = false,
  branch = "v2", -- optional but strongly recommended
  config = function()
    require("hop").setup({
      keys = "etovxqpdygfblzhckisuran",
      quit_key = "<Leader>",
    })
    local hop = require("hop")
    vim.keymap.set("n", "<Leader>w", function()
      hop.hint_words({})
    end, { remap = true })
    vim.keymap.set("n", "<Leader>l", function()
      hop.hint_lines({})
    end, { remap = true })
  end,
}
