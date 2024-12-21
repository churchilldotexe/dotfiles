if true then return {} end

---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    -- "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
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
  specs = {
    { "neo-tree.nvim", optional = true, enabled = false },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>ef",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>ee",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      -- NOTE: this requires a version of yazi that includes
      -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      "<leader>el",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },

    -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
    floating_window_scaling_factor = 0.8,

    -- the transparency of the yazi floating window (0-100). See :h winblend
    yazi_floating_window_winblend = 0,
    yazi_floating_window_border = "rounded",
  },
}
