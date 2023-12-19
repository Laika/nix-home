return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<Leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff-fix", "ruff-format", "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      bib = { "bibtex-tidy" },
      go = { "gofmt", "gofumpt", "goimports-reviser" },
      bash = { "shfmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      nix = { "nixfmt", "nixpkgs-fmt" },
      yaml = { "yamlfmt" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
    format_after_save = {
      lsp_fallback = true,
    },
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type=Spaces",
          "--indent-width=2",
        },
      },
      yamlfmt = {
        prepend_args = {},
      },
      black = {
        prepend_args = { "--line-length=120" },
      },
    },
  },
  init = function()
    vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
}
