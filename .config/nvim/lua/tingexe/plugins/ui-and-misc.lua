return {
  --[[{
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  }, ]]
  -- messages, cmdline and the popupmenu
  {
    --[[
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      opts.presets.lsp_doc_border = true
    end,
   --]]
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },

  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 5000,
      background_colour = '#000000',
      render = 'wrapped-compact',
    },
  },

  -- buffer line
  --[[ {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
      { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab' },
    },
    opts = {
      options = {
        mode = 'tabs',
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  ]]
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      -- Add "oil" to the disabled_filetypes
      disabled_filetypes = { 'neo-tree', 'qf', 'netrw', 'NvimTree', 'lazy', 'mason', 'oil', 'undotree' },
    },
  },
  {
    'prisma/vim-prisma',
  },

  -- filename
  --[[
  
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config {
        virtual_text = false,
      }
    end,
  },
  {
    'b0o/incline.nvim',
    dependencies = {},
    event = 'BufReadPre',
    priority = 1200,
    config = function()
      local helpers = require 'incline.helpers'
      require('incline').setup {
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            ' ',
            guibg = '#363944',
          }
          return buffer
        end,
      }
    end,
  },

  ]]
}
