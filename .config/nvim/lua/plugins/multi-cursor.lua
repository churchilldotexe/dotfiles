return {
  "vscode-neovim/vscode-multi-cursor.nvim",
  event = "VeryLazy",
  cond = not not vim.g.vscode,
  opts = {},
  config = function()
    local cursor = require "vscode-multi-cursor"

    vim.keymap.set({ "n", "x" }, "mm", cursor.create_cursor, { expr = true })
    vim.keymap.set({ "n" }, "mx", cursor.cancel)
    vim.keymap.set("n", "<leader>m", "mciw*:nohl<CR>", { remap = true })

    -- vscode-multi-cursor
    vim.api.nvim_set_hl(0, "VSCodeCursor", {
      bg = "#542fa4",
      fg = "white",
      default = true,
    })

    vim.api.nvim_set_hl(0, "VSCodeCursorRange", {
      bg = "#542fa4",
      fg = "white",
      default = true,
    })
  end,
}
