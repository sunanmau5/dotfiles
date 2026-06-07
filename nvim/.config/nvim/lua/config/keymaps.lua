vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<C-w>l", "<cmd>vsplit<cr>", { desc = "Split window right" })
vim.keymap.set("n", "<C-w>j", "<cmd>split<cr>", { desc = "Split window below" })

vim.keymap.set("n", "<M-=>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-->", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-+>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-_>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })

vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })

vim.keymap.set("n", "<leader>qq", "<cmd>confirm qa<cr>", { desc = "Quit all" })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader><leader>x", "<cmd>so %<cr>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>x", ":.lua<cr>", { desc = "Execute" })
vim.keymap.set("v", "<leader>x", ":lua<cr>", { desc = "Execute" })

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-hightlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
