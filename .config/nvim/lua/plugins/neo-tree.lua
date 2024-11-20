if true then return {} end
-- references:
-- if true then return {} end
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>e"] = false,
          },
        },
      },
    },
  },
  event = "VeryLazy",
  keys = {
    { "<leader>ee", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
    { "<leader>eb", ":Neotree toggle buffers float<CR>", silent = true, desc = "Float buffers" },
    { "<leader>eg", ":Neotree toggle git_status float<CR>", silent = true, desc = "Float git status" },
    {
      "<leader>ef",
      ":Neotree toggle reveal float<CR>",
      silent = true,
      desc = "Float File Explorer and focus on current file",
    },
    --[[   { '<leader><tab>f', ':Neotree toggle reveal right<CR>', silent = true, desc = 'Right File Explorer and focus on current file' },
    { '<leader><tab>b', ':Neotree toggle buffers right<CR>', silent = true, desc = 'Right buffers' },
    { '<leader><tab>g', ':Neotree toggle git_status right<CR>', silent = true, desc = 'Right git status' },
    { '<leader><tab><tab>', ':Neotree toggle right<CR>', silent = true, desc = 'Right File Explorer' },
    ]]
  },
  config = function()
    require("neo-tree").setup {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_modified_markers = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      default_component_configs = {
        indent = {
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└󰮺",
          highlight = "NeoTreeIndentMarker",

          with_expanders = true,
          expander_collapsed = "󰜴",
          expander_expanded = "󰜮",
          -- expander_collapsed = "󰞘",
          -- expander_expanded = "󰞖",
          -- expander_collapsed = '►',
          -- expander_expanded = '▼',
          expander_highlight = "NeoTreeExpander",
        },
        modified = {
          symbol = " ",
          highlight = "NeoTreeModified",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "float",
        width = 45,
      },
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(args)
            if args.position == "left" or args.position == "right" then vim.cmd "wincmd =" end
          end,
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(args)
            if args.position == "left" or args.position == "right" then vim.cmd "wincmd =" end
          end,
        },
      },
    }
  end,
}
