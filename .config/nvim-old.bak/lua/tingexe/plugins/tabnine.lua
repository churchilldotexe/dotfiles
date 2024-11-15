return {
  'codota/tabnine-nvim',
  build = './dl_binaries.sh',
  config = function()
    require('tabnine').setup {
      disable_auto_comment = true,
      -- accept_keymap = '<Tab>',
      dismiss_keymap = '<C-]>',
      debounce_ms = 800,
      suggestion_color = { gui = '#808080', cterm = 244 },
      exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
      log_file_path = nil, -- absolute path to Tabnine log file
      ignore_certificate_errors = false,

      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = '..',
      ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
      show_prediction_strength = true,
      min_percent = 0,
    }

    --- Example integration with Tabnine and LuaSnip; falling back to inserting tab if neither has a completion
    vim.keymap.set('i', '<tab>', function()
      if require('tabnine.keymaps').has_suggestion() then
        return require('tabnine.keymaps').accept_suggestion()
      elseif require('luasnip').jumpable(1) then
        return require('luasnip').jump(1)
      else
        return '<tab>'
      end
    end, { expr = true })
  end,
}

-- require('tabnine').setup {
--   disable_auto_comment = true,
--   accept_keymap = '<Tab>',
--   dismiss_keymap = '<C-]>',
--   debounce_ms = 800,
--   suggestion_color = { gui = '#8087A2', cterm = 244 },
--   codelens_color = { gui = '#8087A2', cterm = 244 },
--   exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
--   log_file_path = nil, -- absolute path to Tabnine log file
-- }
