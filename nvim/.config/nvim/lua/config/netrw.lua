local map = vim.keymap.set

-- if the screen is small, occupy half
vim.g.netrw_winsize = vim.o.columns < 90 and 50 or 30

-- sync current directory and browsing directory
-- this solves the problem with the move command
vim.g.netrw_keepdir = 0

-- hide banner
vim.g.netrw_banner = 0

-- hide dotfiles
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

-- a better copy command
vim.g.netrw_localcopydircmd = "cp -r"

-- toggle the netrw window
map("n", "<leader>e", "<cmd>Lexplore<cr>", { desc = "Toggle netrw" })

-- open netrw on the directory of the current file
map("n", "<leader>E", "<cmd>Lexplore %:p:h<cr>", { desc = "Explore current file directory" })

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
        -- close netrw window
        map_netrw(event, "<leader>e", "<cmd>Lexplore<cr>", "Close netrw")

        -- go to file and close netrw window
        map_netrw(event, "L", "<CR><cmd>Lexplore<cr>", "Open and close netrw")

        -- go back in history
        map_netrw(event, "H", "u", "Go back in history")

        -- go up a directory
        map_netrw(event, "h", "-^", "Go up a directory")

        -- go down a directory / open file
        map_netrw(event, "l", "<CR>", "Open file or directory")

        -- toggle dotfiles
        map_netrw(event, ".", "gh", "Toggle hidden files")

        -- toggle the mark on a file
        map_netrw(event, "<Tab>", "mf", "Toggle file mark")

        -- unmark all files in the buffer
        map_netrw(event, "<S-Tab>", "mF", "Unmark buffer files")

        -- unmark all files
        map_netrw(event, "<leader><Tab>", "mu", "Unmark all files")

        -- 'bookmark' a directory
        map_netrw(event, "bb", "mb", "Bookmark directory")

        -- delete the most recent directory bookmark
        map_netrw(event, "bd", "mB", "Delete latest bookmark")

        -- go to a directory on the most recent bookmark
        map_netrw(event, "bl", "gb", "Go to latest bookmark")

        -- create a file
        map_netrw(event, "ff", "%:w<CR><cmd>buffer #<cr>", "Create file")

        -- rename a file
        map_netrw(event, "fe", "R", "Rename file")

        -- copy marked files
        map_netrw(event, "fc", "mc", "Copy marked files")

        -- copy marked files in the directory under cursor
        map_netrw(event, "fC", "mtmc", "Copy marked files to directory")

        -- move marked files
        map_netrw(event, "fx", "mm", "Move marked files")

        -- move marked files in the directory under cursor
        map_netrw(event, "fX", "mtmm", "Move marked files to directory")

        -- execute a command on marked files
        map_netrw(event, "f;", "mx", "Run command on marked files")

        -- set the directory under the cursor as the current target
        map_netrw(event, "fd", "mtfq", "Set target directory")

        -- show the list of marked files
        map_netrw(event, "fl", [[<cmd>echo join(netrw#Expose("netrwmarkfilelist"), "\n")<cr>]], "List marked files")

        -- show the current target directory
        map_netrw(event, "fq", [[<cmd>echo "Target:" . netrw#Expose("netrwmftgt")<cr>]], "Show target directory")

        -- close the preview window
        map_netrw(event, "P", "<C-w>z", "Close preview window")

        -- delete a file
        map("n", "FF", remove_recursive, { buffer = event.buf, desc = "Delete recursively" })
    end,
})

-- highlight marked files in the same way search matches are.
vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" })
