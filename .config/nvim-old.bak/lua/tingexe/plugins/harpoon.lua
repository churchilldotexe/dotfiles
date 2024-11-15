--[[
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<A-a>",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<A-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<A-" .. i .. ">",
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,

  --[[
  --
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<A-a>", mark.add_file, { desc = "[A]dd file to harpoon" })
    vim.keymap.set("n", "<A-e>", ui.toggle_quick_menu, { desc = "[A]dd file to harpoon" })

    vim.keymap.set("n", "<A-1>", function()
      ui.nav_file(1)
    end, { desc = "toggle [1]st file" })

    vim.keymap.set("n", "<A-2>", function()
      ui.nav_file(2)
    end, { desc = "toggle [2]nd file" })

    vim.keymap.set("n", "<A-3>", function()
      ui.nav_file(3)
    end, { desc = "toggle [3]rd file" })

    vim.keymap.set("n", "<A-4>", function()
      ui.nav_file(4)
    end, { desc = "toggle [4]th file" })

    vim.keymap.set("n", "<A-5>", function()
      ui.nav_file(5)
    end, { desc = "toggle [5]th file" })

    vim.keymap.set("n", "<A-6>", function()
      ui.nav_file(6)
    end, { desc = "toggle [6]th file" })

    vim.keymap.set("n", "<A-7>", function()
      ui.nav_file(7)
    end, { desc = "toggle [7]th file" })

    vim.keymap.set("n", "<A-8>", function()
      ui.nav_file(8)
    end, { desc = "toggle [8]th file" })

    vim.keymap.set("n", "<A-9>", function()
      ui.nav_file(9)
    end, { desc = "toggle [9]th file" })
  end, 
  --
  --
}
  ]]

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        '<A-a>',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon File',
      },
      {
        '<A-e>',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Quick Menu',
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        '<A-' .. i .. '>',
        function()
          require('harpoon'):list():select(i)
        end,
        desc = 'Harpoon to File ' .. i,
      })
    end
    return keys
  end,
}
