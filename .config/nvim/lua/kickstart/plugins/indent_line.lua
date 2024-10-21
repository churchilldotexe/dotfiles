return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      -- indent = { char = '│' },
      indent = { char = '░' },
      scope = { enabled = true },
    },
  },
}

-- https://www.codetable.net/altkeycodes
