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
  -- lualine: minimal setup (mode + branch + copilot)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local theme = require("lualine.themes.ayu_mirage")
      theme.normal.c.bg = "#1f2430"
      theme.inactive.c.bg = "#1f2430"

      opts.options = opts.options or {}
      opts.options.theme = theme
      opts.options.component_separators = ""
      opts.options.section_separators = ""

      -- minimal sections: mode | branch + diff | spacer | copilot
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            function()
              local ok, copilot = pcall(require, "copilot.api")
              if ok and copilot.status and copilot.status.data then
                local status = copilot.status.data.status
                if status == "InProgress" then return "" end
                if status == "Warning" then return "" end
              end
              return ""
            end,
          },
        },
      }
      opts.inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }
    end,
  },
}
