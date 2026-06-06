vim.api.nvim_create_user_command("Floaterminal", function()
    require("floaterminal").toggle()
end, { desc = "Toggle floating terminal" })
