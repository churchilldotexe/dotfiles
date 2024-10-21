return {
  {--[[
    'themaxmarchuk/tailwindcss-colors.nvim',
    lazy = true,
    module = 'tailwindcss-colors',
    config = function()
      require('tailwindcss-colors').setup()
    end,
    ]]
  },
  {
    'razak17/tailwind-fold.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'javascriptreact', 'php', 'blade' },
  },
  {
    -- High-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    lazy = true,
    config = function()
      require('tailwindcss-colorizer-cmp').setup {
        color_square_width = 2,
      }
    end,
  },
}
