-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any al autocmds here
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
--   callback = function()
--     vim.api.nvim_set_hl(0, "@function", {
--       bold = true,
--       blend = 50,
--       italic = true,
--       fg = "#f8f8ff",
--       bg = "#020617",
--     })
--     -- vim.api.nvim_set_hl(0, '@variable', { bold = true, fg = '#f8f8ff' })
--   end,
-- })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd('InsertLeave', {
--   pattern = '*',
--   -- command = 'write!',
--   command = ':w!<CR>',
-- })

-- local Color, colors, Group, groups, styles = require('colorbuddy').setup {}
-- Group.new('@constant', colors.noir_2, nil, styles.bold)
-- Group.new('@method', colors.noir_0, nil, styles.bold + styles.italic)

--[[

local timer = nil

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    -- Cancel any existing timer
    if timer then
      timer:stop()
    end

    -- Start a new timer
    timer = vim.defer_fn(function()
      -- Check if we're still in normal mode
      if vim.api.nvim_get_mode().mode == 'n' then
        -- Save the file
        vim.cmd 'silent! write'
        -- Run autoformatting
        vim.cmd 'silent! lua vim.lsp.buf.format()'
        -- Show notification
        vim.notify('File saved', vim.log.levels.INFO, { title = 'Auto Save', timeout = 3000 })
      end
    end, 5000) -- 5000 ms = 5 seconds
  end,
})

-- Cancel the timer if we re-enter insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    if timer then
      timer:stop()
      timer = nil
    end
  end,
})

]]

-- vim.api.nvim_create_autocmd('InsertLeave', {
--   pattern = '*',
--   callback = function()
--     require('conform').format { async = true, lsp_fallback = true }
--   end,
-- })

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'p' or vim.v.event.operator == 'P' then
      require('conform').format { async = true, lsp_fallback = true }
    end
  end,
})
