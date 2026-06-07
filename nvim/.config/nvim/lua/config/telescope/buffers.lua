local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function delete_buffer(bufnr)
    local ok, err = pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
    if not ok then
        vim.notify(err, vim.log.levels.WARN)
    end
end

M.attach_mappings = function(prompt_bufnr, map)
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

return M
