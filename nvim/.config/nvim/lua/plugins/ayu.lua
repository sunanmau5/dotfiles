return {
  -- Add ayu colorscheme
  {
    "Shatur/neovim-ayu",
    name = "ayu",
    lazy = false,
    priority = 1000,
  },
  -- Configure LazyVim to use ayu-mirage
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu-mirage",
    },
  },
  -- lualine: ayu_mirage with bg matching tmux
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local theme = require'lualine.themes.ayu_mirage'
      -- only normal and inactive have c section, others inherit from normal
      theme.normal.c.bg = "#1f2430"
      theme.inactive.c.bg = "#1f2430"
      opts.options = opts.options or {}
      opts.options.theme = theme
      opts.options.component_separators = ""
      opts.options.section_separators = ""
    end,
  },
}
