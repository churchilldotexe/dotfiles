return {
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
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle',
    keys = {
      { '<leader>mx', mode = { 'n', 'i', 'v' } },
    },
  },

  { 'karb94/neoscroll.nvim', config = true },

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

  {
    'danymat/neogen',
    keys = {
      {
        '<leader>ng',
        function()
          require('neogen').generate()
        end,
        desc = 'Generate code annotations',
      },
    },
    opts = {
      snippet_engine = 'luasnip',
    },
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  {
    'ahmedkhalf/project.nvim',
    name = 'project_nvim',
    opts = {
      detection_methods = { 'pattern' },
      -- only create projects in git repos
      patterns = { '.git' },
    },
    init = function()
      local telescope = require 'telescope'
      local map = require('tingexe.util').map

      telescope.load_extension 'projects'
      map({ 'n', 'v' }, '<leader>tp', telescope.extensions.projects.projects)
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    'tpope/vim-projectionist',
    config = function()
      vim.g['projectionist_heuristics'] = {
        artisan = {
          ['*'] = {
            start = 'sail up -d',
            console = 'sail tinker',
          },
        },
      }
    end,
  },

  -- numToStr/FTerm.nvim
  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = '<leader>tt',
      direction = 'float',
      highlights = {
        NormalFloat = {
          link = 'NormalFloat',
        },
        FloatBorder = {
          link = 'FloatBorder',
        },
      },
      float_opts = {
        border = 'rounded',
        width = function()
          return math.ceil(vim.api.nvim_get_option_value('columns', { scope = 'global' }) * 0.8)
        end,
        height = function()
          return math.ceil(vim.api.nvim_get_option_value('lines', { scope = 'global' }) * 0.8 - 4)
        end,
      },
      winbar = {
        enabled = true,
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
}
