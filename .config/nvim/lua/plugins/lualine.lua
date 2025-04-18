if true then return {} end

return {
  "nvim-lualine/lualine.nvim",
  specs = {
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts) opts.statusline = nil end,
    },
  },
  config = function()
    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
    }

    local filename = {
      "filename",
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function() return vim.fn.winwidth(0) > 100 end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    local cmd = {
      require("noice").api.status.command.get,
      cond = require("noice").api.status.command.has,
      color = { fg = "#ff9e64" },
    }

    local search = {
      require("noice").api.status.search.get,
      cond = require("noice").api.status.search.has,
      color = { fg = "#ff9e64" },
    }

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "gruvbox-material", -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { "branch" },
        lualine_c = { filename },
        lualine_x = {
          diagnostics,
          diff,
          cmd,
          { "encoding", cond = hide_in_width },
          { "filetype", cond = hide_in_width },
        },
        lualine_y = { search, "location" },
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "fugitive" },
    }
  end,
}
