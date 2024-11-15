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
      local map = require('tingexe.util').map

      map('n', '<leader>mdn', ':MarkdownPreview<CR>')
      map('n', '<leader>mds', ':MarkdownPreviewStop<CR>')
      -- vim.keymap.set('n', '<leader>mdn', ':MarkdownPreview<CR>')
      -- vim.keymap.set('n', '<leader>mds', ':MarkdownPreviewStop<CR>')

      vim.g.mkdp_markdown_css = 'C:/users/micha/appdata/local/nvim/md.css'
      vim.g.mkdp_highlight_css = 'C:/users/micha/appdata/local/nvim/mdhl.css'
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'ellisonleao/glow.nvim',
    keys = {
      {
        '<leader>mdp',
        ':w<cr>:Glow<cr>',
        desc = 'Render markdown',
      },
    },
    opts = {
      border = 'rounded',
      pager = false,
      width = 120,
    },
  },
}
