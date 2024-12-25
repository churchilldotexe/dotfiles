return {
  { "aaron-p1/match-visual.nvim" },
  {
    "tversteeg/registers.nvim",
    cmd = "Registers",
    config = true,
    keys = {
      { '"', mode = { "n", "v" } },
      { "<C-R>", mode = "i" },
    },
    name = "registers",
  },
  --[[
  {
    "leath-dub/snipe.nvim",
    keys = {
      { "<leader><leader>", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" },
    },
    opts = {},
  },
  --]]
}
