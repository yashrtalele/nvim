require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- quit-all
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- git
map("n", "<leader>gb", "<cmd> Telescope git_branches <CR>", { desc = "Git branches" })
map("n", "<leader>gp", "<cmd> Gitsigns preview_hunk <CR>", { desc = "Preview Hunk" })
map("n", "<leader>gc", "<cmd> Gitsigns toggle_current_line_blame <CR>", { desc = "Toggle current line blame" })

-- Multi line indent in visual mode
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "<", "<gv", { desc = "Indent left" })
