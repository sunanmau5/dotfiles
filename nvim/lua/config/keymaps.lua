-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- normal mode
map("n", "<S-h>", "^", { desc = "start of line" })
map("n", "<S-l>", "$", { desc = "end of line" })