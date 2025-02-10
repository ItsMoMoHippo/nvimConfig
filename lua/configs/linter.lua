local lint = require "lint"

lint.linters.clangtidy.args = {
  "--checks=*,-modernize-use-trailing-return-type",
  "--warnings-as-errors=*",
}

lint.linters_by_ft = {
  cpp = { "clangtidy" },
  c = { "clangtidy" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    lint.try_lint()
  end,
})

return lint
