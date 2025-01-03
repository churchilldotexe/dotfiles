return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    config = function()
      local builtin = require "telescope.builtin"
      require("telescope").setup {
        defaults = {
          mappings = {
            n = {
              -- delete buffer
              ["d"] = require("telescope.actions").delete_buffer,
              -- close the buffer (<leader><leader>)
              ["q"] = require("telescope.actions").close,
            },
          },
        },
        -- pickers = {}
      }

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set(
        "n",
        "<leader><leader>",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>",
        { desc = "[ ] Find existing buffers" }
      )

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        "n",
        "<leader>s/",
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          }
        end,
        { desc = "[S]earch [/] in Open Files" }
      )

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set(
        "n",
        "<leader>snf",
        function() builtin.find_files { cwd = vim.fn.stdpath "config" } end,
        { desc = "[S]earch [N]eovim [F]iles" }
      )
    end,
  },
}
