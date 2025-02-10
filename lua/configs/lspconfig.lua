-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "cssls",
  "clangd", --installed locally
  "gopls",
  "zls",
  "pyright",
  "rust_analyzer", --installed locally
  "ts_ls",
  "ols",
  "jdtls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- Custom config for gopls
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      usePlaceholders = true, -- enables placeholders for function signatures
      analyses = {
        unusedparams = true, -- checks for unused parameters
        shadow = true, -- detects variable shadowing
      },
      staticcheck = true, -- runs additional checks like `staticcheck`
    },
  },
}

lspconfig.cmake.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/cmake-language-server" },
  root_dir = lspconfig.util.root_pattern "CMakeLists.txt",
  settings = {},
}

-- Custom config for tsserver
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- Disable tsserver formatting in favor of another formatter
    client.server_capabilities.documentFormattingProvider = false

    -- Use the default on_attach from NvChad
    nvlsp.on_attach(client, bufnr)
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
