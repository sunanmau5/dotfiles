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
        require("dbee").setup()
    end,
}
