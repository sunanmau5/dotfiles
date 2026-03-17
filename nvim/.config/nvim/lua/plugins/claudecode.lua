return {
  "coder/claudecode.nvim",
  -- No snacks.nvim dependency needed
  keys = {
    { "<leader>ac", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send to Claude", mode = { "n", "v" } },
  },
  opts = {
    terminal = {
      provider = "native",
    },
  },
}
