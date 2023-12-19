vim.keymap.set("n", "<Leader>xx", "<cmd>TroubleToggle<CR>", { remap = false })
return {
  "folke/trouble.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
}
