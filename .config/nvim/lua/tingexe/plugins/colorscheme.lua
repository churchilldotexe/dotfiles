return {

  {
    'rebelot/kanagawa.nvim',
    enabled = true,
    priority = 1000,
    config = function()
      -- Default options:
      require('kanagawa').setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Telescope
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            -- Cmp popup
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
        theme = 'dragon', -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = 'dragon', -- try "dragon" !
          light = 'lotus',
        },
      }
      -- setup must be called before loading
      vim.cmd 'colorscheme kanagawa'
    end,
  },

  {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    opts = {},
    config = function()
      require('everforest').setup {
        -- Your config here
      }
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
      -- vim.cmd.colorscheme 'everforest'
    end,
  },

  -- Using lazy.nvim
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }

      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
      -- require('bamboo').load()
    end,
  },
  {
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup {
        transparent = true, -- don't set background
        style = {
          -- "none" is the same thing as default. But "italic" and "bold" are also valid options
          boolean = 'none',
          number = 'none',
          float = 'none',
          error = 'none',
          comments = 'italic',
          conditionals = 'none',
          functions = 'none',
          headings = 'bold',
          operators = 'none',
          strings = 'italic',
          variables = 'none',

          -- keywords
          keywords = 'none',
          keyword_return = 'none',
          keywords_loop = 'none',
          keywords_label = 'none',
          keywords_exception = 'none',

          -- builtin
          builtin_constants = 'none',
          builtin_functions = 'none',
          builtin_types = 'none',
          builtin_variables = 'none',
        },
        -- Override colors
        colors = {
          bg = '#18191a',
          fg = '#cdcdcd',
          floatBorder = '#878787',
          line = '#282830',
          comment = '#646477',
          builtin = '#bad1ce',
          func = '#be8c8c',
          string = '#deb896',
          number = '#d2a374',
          property = '#c7c7d4',
          constant = '#b4b4ce',
          parameter = '#b9a3ba',
          visual = '#363738',
          error = '#d2788c',
          warning = '#e6be8c',
          hint = '#8ca0dc',
          operator = '#96a3b2',
          keyword = '#7894ab',
          type = '#a1b3b9',
          search = '#465362',
          plus = '#8faf77',
          delta = '#e6be8c',
        },
        vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true }),
        vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true }),
        vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true }),
        -- vim.cmd.colorscheme 'vague',
      }
    end,
  },
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true }),
  vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true }),
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true }),
}
