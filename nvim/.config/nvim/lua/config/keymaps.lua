-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- resize current window width (alt+= to increase, alt+- to decrease)
map({ "n", "t" }, "<M-=>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
map({ "n", "t" }, "<M-->", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })

-- terminal: window navigation with ctrl+h/j/k/l (no need to exit terminal mode first)
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
