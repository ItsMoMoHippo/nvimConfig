local o = {
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "c",
      "lua",
      "luadoc",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "cpp",
      "rust",
      "zig",
      "go",
      "cmake",
      "python",
      "javascript",
      "odin",
      "java",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}

return o
