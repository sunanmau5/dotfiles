local is_inside_work_tree = {}

local function project_files()
    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end,
    cmd = "Telescope",
    keys = {
        { "<C-p>", project_files, desc = "Find files" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        {
            "<leader>/",
            function()
                require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") })
            end,
            mode = "v",
            desc = "Grep word under cursor",
        },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    },
    opts = function()
        local actions = require("telescope.actions")
        local additional_rg_args = { "--hidden", "--glob", "!**/.git/*" }
        return {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-b>"] = actions.preview_scrolling_up,
                        ["<C-l>"] = actions.select_vertical,
                        ["<C-j>"] = actions.select_horizontal,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
                live_grep = { additional_args = additional_rg_args },
                grep_string = { additional_args = additional_rg_args },
            },
        }
    end,
}
