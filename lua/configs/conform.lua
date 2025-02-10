local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    cpp = { "clang_format" }, --installed locally
    c = { "clang_format" }, --installed locally
    rust = { "rustfmt" }, --installed locally
    go = { "gofumpt" },
    python = { "black" },
  },

  format_on_save = {
    enabled = true,
    pattern = {
      "*.lua",
      "*.css",
      "*.html",
      "*.cpp",
      "*.c",
      "*.rs",
      "*.go",
      "*.zig",
      "*.py",
    },
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
