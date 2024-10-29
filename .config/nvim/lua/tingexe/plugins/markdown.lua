return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    config = function()
      vim.keymap.set('n', '<leader>mdn', ':MarkdownPreview<CR>')
      vim.keymap.set('n', '<leader>mds', ':MarkdownPreviewStop<CR>')

      vim.g.mkdp_markdown_css = 'C:/users/micha/appdata/local/nvim/md.css'
      vim.g.mkdp_highlight_css = 'C:/users/micha/appdata/local/nvim/mdhl.css'
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    ft = { 'markdown', 'norg', 'rmd', 'org' },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      vim.keymap.set('n', '<leader>um', function()
        local m = require 'render-markdown'
        local enabled = require('render-markdown.state').enabled

        if enabled then
          m.disable()
        else
          m.enable()
        end
      end, { desc = 'Toggle Render Markdown' })
    end,
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you prefer nvim-web-devicons
  },
}
