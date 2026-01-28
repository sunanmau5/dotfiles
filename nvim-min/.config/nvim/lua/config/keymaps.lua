local map = vim.keymap.set

map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")

map("n", "<Esc>", "<cmd>nohlsearch<cr>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<M-=>", "<cmd>vertical resize +5<cr>")
map("n", "<M-->", "<cmd>vertical resize -5<cr>")

map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")
map("n", "<leader>bd", "<cmd>bdelete<cr>")
map("n", "<C-w>", "<cmd>bdelete<cr>")

map("n", "<M-j>", "<cmd>m .+1<cr>==")
map("n", "<M-k>", "<cmd>m .-2<cr>==")
map("v", "<M-j>", ":m '>+1<cr>gv=gv")
map("v", "<M-k>", ":m '<-2<cr>gv=gv")
map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", [["_dP]])

map("i", "<C-Space>", "<C-x><C-o>")

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")

map("n", "<leader>l", "<cmd>Lazy<cr>")

map("n", "<leader>qq", "<cmd>confirm qa<cr>")
