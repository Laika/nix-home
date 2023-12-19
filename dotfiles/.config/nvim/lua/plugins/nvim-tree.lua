return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- custom mappings
      vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "<Leader>t", api.tree.change_root_to_parent, opts("Toggle"))
    end
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = my_on_attach,
    })
  end,
}
