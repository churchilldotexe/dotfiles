if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- dadbod ui
vim.keymap.set(
  { "n", "x" },
  "<leader>ldb",
  "<cmd>Neotree close<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
  { desc = "[L]sp [D]ata[B]ase UI" }
)
