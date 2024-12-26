-- Wait for plugins to initialize before setting up the autocommand
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy", -- Ensures plugins are loaded
  callback = function()
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { "*.md", "*.mdx" },
      callback = function()
        vim.cmd "SupermavenStart"
        vim.cmd "NoiceDismiss"
      end,
    })

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { "*" },
      callback = function()
        -- Skip running SupermavenStop if it's a markdown file
        local ext = vim.fn.expand "%:e"
        if ext ~= "md" and ext ~= "mdx" then
          vim.cmd "SupermavenStop"
          vim.cmd "NoiceDismiss"
        end
      end,
    })
  end,
})