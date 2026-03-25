return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        require("dbee").install()
    end,
    cmd = "Dbee",
    keys = {
        { "<leader>db", "<cmd>Dbee toggle<cr>", desc = "Toggle Dbee" },
    },
    config = function()
        require("dbee").setup({
            window_layout = require("dbee.layouts").Default:new({
                call_log_height = 1,
            }),
        })
    end,
}
