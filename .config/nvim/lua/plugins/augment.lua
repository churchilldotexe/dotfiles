return {
  {
    "augmentcode/augment.vim",
    config = function()
      vim.keymap.set("i", "<C-y>", function() vim.fn["augment#Accept"]() end, { noremap = true, silent = true })

      vim.keymap.set("i", "<CR>", function() vim.fn["augment#Accept"] "\n" end, { noremap = true, silent = true })
    end,
  },
}
