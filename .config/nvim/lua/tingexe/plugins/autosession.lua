--[[
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {

    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 0,
    branch = true, -- use git branch to save session
  },
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },

}
  ]]
return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
    }

    local keymap = vim.keymap

    keymap.set('n', '<leader>ql', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' }) -- restore last workspace session for current directory
    keymap.set('n', '<leader>qs', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' }) -- save workspace session for current working directory
  end,
}
