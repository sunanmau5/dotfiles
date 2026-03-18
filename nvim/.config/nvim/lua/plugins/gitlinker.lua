return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = {
    router = {
      blame = {
        ["^github%.com"] = "https://github.com/{_A.USER}/{_A.REPO}/commit/{_A.REV}",
      },
    },
  },
  keys = {
    { "<leader>go", "<cmd>GitLink! blame<cr>", desc = "Open blame commit in browser" },
  },
}
