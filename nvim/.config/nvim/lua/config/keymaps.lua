local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Escape insert mode" })
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })

map("n", "<C-w>l", "<cmd>vsplit<cr>", { desc = "Split window right" })
map("n", "<C-w>j", "<cmd>split<cr>", { desc = "Split window below" })

map("n", "<M-=>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
map("n", "<M-->", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map("n", "<M-+>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
map("n", "<M-_>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

map("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>qq", "<cmd>confirm qa<cr>", { desc = "Quit all" })
