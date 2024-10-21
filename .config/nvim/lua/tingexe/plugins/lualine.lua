-- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file
-- https://github.com/folke/noice.nvim?tab=readme-ov-file#-statusline-components
--
-- if true then
--   return {}
-- end

--[[
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'meuter/lualine-so-fancy.nvim',
  },
  enabled = true,
  lazy = false,
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  config = function()
    -- New color table and conditions
    local colors = {
      bg = 'None', -- Ensure this is a valid color or nil
      fg = '#45657b',
      yellow = '#ecc58d',
      cyan = '#21c7a8',
      darkblue = '#081633',
      green = '#aedb67',
      orange = '#FF8800',
      magenta = '#c792eb',
      blue = '#82aaff',
      red = '#ef5350',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Configuration for lualine
    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
        disabled_filetypes = {
          statusline = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {
          -- {
          -- 	require("noice").api.statusline.mode.get,
          -- 	cond = require("noice").api.statusline.mode.has,
          -- 	color = { fg = "#ff9e64" },
          -- },
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }

    -- Helper functions for inserting components
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- Component definitions
    -- Add the components setup here following the new configuration
    ins_left {
      function()
        return ' '
      end,
      color = { fg = colors.bg },        -- Sets highlighting of component
      padding = { left = 0, right = 1 }, -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        return ''
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.green,
          i = colors.violet,
          v = colors.yellow,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_left {
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2

    ins_left {
      function()
        return '%='
      end,
    }

    ins_left {
      'fancy_lsp_servers',
      'fancy_diff',
      'progress',
    }

    -- Add components to right sections
    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right { 'location' }

    ins_right { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.violet, gui = 'bold' },
    }
    -- ins_right {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.bg },
    --   padding = { left = 1 },
    -- }
    -- Initialize lualine with the configuration
    require('lualine').setup(config)
  end,
}
]]

--[[
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'meuter/lualine-so-fancy.nvim',
  },
  enabled = true,
  lazy = false,
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = {
          {
            require('noice').api.statusline.mode.get,
            cond = require('noice').api.statusline.mode.has,
            color = { fg = '#ff9e64' },
          },
          {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
            color = { fg = '#ff9e64' },
          },
        },
        lualine_a = {
          {
            'buffers',
          },
        },
      },
    }
  end,
}
]]

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local mode = {
      'mode',
      fmt = function(str)
        return ' ' .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
    }

    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    local cmd = {
      require('noice').api.status.command.get,
      cond = require('noice').api.status.command.has,
      color = { fg = '#ff9e64' },
    }

    local search = {
      require('noice').api.status.search.get,
      cond = require('noice').api.status.search.has,
      color = { fg = '#ff9e64' },
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox-material', -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, cmd, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { search, 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
