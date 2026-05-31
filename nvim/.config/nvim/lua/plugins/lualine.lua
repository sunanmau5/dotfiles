return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local theme = require("lualine.themes.ayu_mirage")
        for _, mode in pairs(theme) do
            if mode.c then
                mode.c.bg = "NONE"
            end
        end
        return {
            options = {
                theme = theme,
                component_separators = "",
                section_separators = "",
                disabled_filetypes = { statusline = { "netrw" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = { { "filename", path = 1 }, { "searchcount", maxcount = 999999 } },
            },
        }
    end,
}
