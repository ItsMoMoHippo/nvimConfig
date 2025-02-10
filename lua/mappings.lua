require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "extra escape option" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "ctrl save" })
map("n", "<leader>cs", ":nohlsearch<CR>", { silent = true, desc = "clear search highlighting" })
map(
  "n",
  "<leader>rm",
  "<cmd>lua require('render-markdown').toggle()<CR>",
  { silent = true, desc = "render the markdownfile" }
)
