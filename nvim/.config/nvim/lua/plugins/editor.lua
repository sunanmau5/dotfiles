return {
  -- disable snacks picker and explorer since we're using telescope + neo-tree
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>E", false },
      { "<leader>e", false },
    },
    opts = {
      picker = { enabled = false },
      explorer = { enabled = false },
      scroll = { enabled = false },
      dashboard = { enabled = false },
      indent = {
        animate = { enabled = false },
      },
      terminal = {
        win = {
          position = "float",
          border = "rounded",
          width = 0.9,
          height = 0.9,
          wo = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
        },
      },
    },
  },
  -- disable tokyonight (lazyvim default colorscheme)
  { "folke/tokyonight.nvim", enabled = false },

  -- telescope customization
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
      pickers = {
        grep_string = {
          additional_args = { "--hidden" },
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
      },
    },
  },

  -- neo-tree on the right side
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false, -- load immediately for auto-open
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
      { "<leader>E", "<cmd>Neotree toggle dir=%:p:h<cr>", desc = "Explorer (cwd)" },
    },
    opts = {
      -- hijack netrw when opening a directory
      hijack_netrw_behavior = "open_current",
      -- open on startup when no file specified
      open_on_setup = true,
      window = {
        position = "right",
        width = 35,
        mappings = {
          -- Sources:
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/163#discussioncomment-4747082
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/163#discussioncomment-7663286
          -- Jump up to parent directory on file or closed directory, or close on open directory
          ["h"] = function(state)
            local node = state.tree:get_node()
            if (node.type == "directory" or node:has_children()) and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          -- Open on file or closed directory, or jump down to top subdirectory on open directory
          ["l"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" or node:has_children() then
              if not node:is_expanded() then
                state.commands.toggle_node(state)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            else
              require("neo-tree.sources.filesystem.commands").open(state)
            end
          end,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
      filesystem = {
        -- show hidden/dotfiles
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
    config = function(_, opts)
      -- disable signcolumn in neo-tree to remove the margin/thick line
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neo-tree",
        callback = function()
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
        end,
      })
      require("neo-tree").setup(opts)
    end,
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            vim.schedule(function()
              require("neo-tree.command").execute({ action = "show" })
            end)
          end
        end,
      })
    end,
  },

  -- disable inlay hints by default
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
        signs = false,
      },
      autoformat = false,
    },
  },
}
