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
    opts = {},
    config = function()
      require('render-markdown').setup {}
    end,
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you prefer nvim-web-devicons
  },
}
