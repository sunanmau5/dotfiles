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
        { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        {
            "<leader>fg",
            function()
                require("config.telescope.multigrep").live_multigrep()
            end,
            desc = "Live multigrep",
        },
        {
            "<leader>/",
            function()
                require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") })
            end,
            mode = "v",
            desc = "Grep word under cursor",
        },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },
        { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
        { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Go to type definition" },
    },
    opts = function()
        local actions = require("telescope.actions")
        local additional_rg_args = { "--hidden", "--fixed-strings", "--glob", "!**/.git/*" }

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
                    theme = "ivy",
                },
                buffers = {
                    sort_mru = true,
                    ignore_current_buffer = true,
                    attach_mappings = require("config.telescope.buffers").attach_mappings,
                },
                live_grep = { additional_args = additional_rg_args },
                grep_string = { additional_args = additional_rg_args },
            },
            extensions = {
                fzf = {},
            },
        }
    end,
}
