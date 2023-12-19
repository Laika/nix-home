local lsp_flags = {
  debounce_text_changes = 150,
}

local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
  vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  -- event = "VeryLazy",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "lukas-reineke/lsp-format.nvim",
      config = function()
        require("lsp-format").setup({})
        require("lspconfig").gopls.setup({ on_attach = on_attach })
        require("lspconfig").lua_ls.setup({ on_attach = on_attach })
      end,
    },
  },
}
