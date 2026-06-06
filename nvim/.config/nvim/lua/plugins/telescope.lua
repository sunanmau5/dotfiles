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
        {
            "<C-p>",
            function()
                require("utils").project_files()
            end,
            desc = "Find files",
        },
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
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },
    },
    opts = function()
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local additional_rg_args = { "--hidden", "--glob", "!**/.git/*" }

        local function delete_buffer(bufnr)
            local ok, err = pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
            if not ok then
                vim.notify(err, vim.log.levels.WARN)
            end
        end

        local function buffer_mappings(prompt_bufnr, map)
            local function refresh_buffers()
                actions.close(prompt_bufnr)
                vim.schedule(function()
                    require("telescope.builtin").buffers()
                end)
            end

            local function delete_selected_buffer()
                local selection = action_state.get_selected_entry()
                if selection and selection.bufnr then
                    delete_buffer(selection.bufnr)
                    refresh_buffers()
                end
            end

            local function delete_selected_buffers()
                local picker = action_state.get_current_picker(prompt_bufnr)
                local selection = picker:get_multi_selection()

                if vim.tbl_isempty(selection) then
                    delete_selected_buffer()
                    return
                end

                for _, entry in ipairs(selection) do
                    delete_buffer(entry.bufnr)
                end
                refresh_buffers()
            end

            map("n", "dd", delete_selected_buffer)
            map("n", "<C-d>", delete_selected_buffers)
            map("i", "<C-d>", delete_selected_buffers)

            return true
        end

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
                buffers = {
                    sort_mru = true,
                    ignore_current_buffer = true,
                    attach_mappings = buffer_mappings,
                },
                live_grep = { additional_args = additional_rg_args },
                grep_string = { additional_args = additional_rg_args },
            },
        }
    end,
}
