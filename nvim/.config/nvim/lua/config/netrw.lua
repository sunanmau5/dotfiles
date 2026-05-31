local map = vim.keymap.set

-- if the screen is small, occupy half
vim.g.netrw_winsize = vim.o.columns < 90 and 50 or 20

-- sync current directory and browsing directory
-- this solves the problem with the move command
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = ""
vim.g.netrw_localcopydircmd = "cp -r"

map("n", "<leader>e", "<cmd>Lexplore!<cr>", { desc = "Toggle netrw" })
map("n", "<leader>E", "<cmd>Lexplore! %:p:h<cr>", { desc = "Explore current file directory" })

local function map_netrw(event, lhs, rhs, desc)
    map("n", lhs, rhs, { buffer = event.buf, remap = true, desc = desc })
end

local function remove_recursive()
    if vim.bo.filetype ~= "netrw" then
        return
    end

    -- prepare the delete command
    -- make it so that is triggered by just pressing enter
    vim.cmd([[cnoremap <buffer> <CR> rm -r<CR>]])

    -- unmark all files (don't want to delete anything by accident)
    vim.cmd.normal({ "mu", bang = true })

    -- mark the file/directory under the cursor
    vim.cmd.normal({ "mf", bang = true })

    -- show the prompt to enter the command
    -- in here you either press enter to confirm
    -- or press ctrl+c to abort.
    -- don't do anything else!
    pcall(function()
        vim.cmd.normal({ "mx", bang = true })
    end)

    -- undo the enter keymap
    pcall(function()
        vim.cmd([[cunmap <buffer> <CR>]])
    end)
end

-- better keymaps for netrw
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function(event)
        map_netrw(event, "<leader>e", "<cmd>Lexplore!<cr>", "Close netrw")
        map_netrw(event, "L", "<CR><cmd>Lexplore!<cr>", "Open and close netrw")
        map_netrw(event, "H", "u", "Go back in history")
        map_netrw(event, "h", "-^", "Go up a directory")
        map_netrw(event, "l", "<CR>", "Open file or directory")
        map_netrw(event, ".", "gh", "Toggle hidden files")
        map_netrw(event, "<Tab>", "mf", "Toggle file mark")
        map_netrw(event, "<S-Tab>", "mF", "Unmark buffer files")
        map_netrw(event, "<leader><Tab>", "mu", "Unmark all files")
        map_netrw(event, "bb", "mb", "Bookmark directory")
        map_netrw(event, "bd", "mB", "Delete latest bookmark")
        map_netrw(event, "bl", "gb", "Go to latest bookmark")
        map_netrw(event, "ff", "%:w<CR><cmd>buffer #<cr>", "Create file")
        map_netrw(event, "fe", "R", "Rename file")
        map_netrw(event, "fc", "mc", "Copy marked files")
        map_netrw(event, "fC", "mtmc", "Copy marked files to directory")
        map_netrw(event, "fx", "mm", "Move marked files")
        map_netrw(event, "fX", "mtmm", "Move marked files to directory")
        map_netrw(event, "f;", "mx", "Run command on marked files")
        map_netrw(event, "fd", "mtfq", "Set target directory")
        map_netrw(event, "fl", [[<cmd>echo join(netrw#Expose("netrwmarkfilelist"), "\n")<cr>]], "List marked files")
        map_netrw(event, "fq", [[<cmd>echo "Target:" . netrw#Expose("netrwmftgt")<cr>]], "Show target directory")
        map_netrw(event, "P", "<C-w>z", "Close preview window")
        map("n", "FF", remove_recursive, { buffer = event.buf, desc = "Delete recursively" })
    end,
})

-- highlight marked files in the same way search matches are
vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" })
vim.api.nvim_set_hl(0, "netrwTreeBar", { fg = "#5c6773" })
