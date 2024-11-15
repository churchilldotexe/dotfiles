return {
  {

    -- render-markdown.nvim [executables] ~
    -- - WARNING latex2text: not installed
    --   - ADVICE:
    --     - Disable LaTeX support to avoid this warning by setting { latex = { enabled = false } }
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown',
    opts = { latex = { enabled = false } },
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you use the mini.nvim suite
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
