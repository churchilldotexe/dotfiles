return {

  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "pint", "php_cs-fixer" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs-fixer" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {},
    config = function()
      require("lint").linters_by_ft = {
        php = {},
        blade = { "htmlhint" },
      }
    end,
  },
}
