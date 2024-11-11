local slow_format_filetypes = {
  injected = true,
}

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true, timeout_ms = 5000 }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      log_level = vim.log.levels.WARN,
      formatters = {
        prettier = {
          prepend_args = { '--ignore-unknown' },
        },
      },
      formatters_by_ft = {
        blade = { 'pint', 'prettier', 'blade-formatter', stop_after_first = true },
        json = { 'prettier', 'jq', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        lua = { 'stylua' },
        markdown = { 'prettier', 'markdownlint', stop_after_first = true },
        php = { 'pint', 'phpcbf', 'php_cs_fixer', stop_after_first = true },
        rust = { 'rustfmt', stop_after_first = true },
        sql = { 'pg_format', 'sqlfmt', stop_after_first = true },
        yaml = { 'yamlfmt' },
        ['*'] = { 'injected' },

        -- html = { 'prettier' },
        -- markdown = { 'prettier' },
        astro = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
        ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      },
      format_on_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        local function on_format(err)
          if err and err:match 'timeout$' then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        return { timeout_ms = 500, lsp_fallback = true }, on_format
      end,
      format_after_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { timeout_ms = 5000, lsp_fallback = true }
      end,
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}

--[[
local slow_format_filetypes = {
  injected = true,
}

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>mf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[M]anual [F]ormat buffer',
    },
  },
  opts = {
    format_on_save = function(bufnr)
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      local function on_format(err)
        if err and err:match 'timeout$' then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 500, lsp_fallback = true }, on_format
    end,
    format_after_save = function(bufnr)
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      return { timeout_ms = 5000, lsp_fallback = true }
    end,
    -- default_format_opts = {
    --   timeout_ms = 3000,
    --   async = false, -- not recommended to change
    --   quiet = false, -- not recommended to change
    --   lsp_format = 'fallback', -- not recommended to change
    -- },
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      --
      --
      php = { 'pint', 'phpcbf', 'php_cs_fixer', stop_after_first = true },
      blade = { 'blade-formatter', 'prettier', stop_after_first = true },
      prisma = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      -- markdown = { 'prettier' },
      astro = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
      ['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
    },
    formatter = {
      ['markdown-toc'] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find '<!%-%- toc %-%->' then
              return true
            end
          end
        end,
      },
      ['markdownlint-cli2'] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == 'markdownlint'
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
    },
  },
}

--]]

--[[
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        prettier = {
          condition = function(_, ctx)
            return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
          end,
        },

        biome = {
          condition = function(ctx)
            return vim.fs.find({ 'biome.json' }, { path = ctx.filename, upward = true })[1]
          end,
        },
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
      ]]

--[[
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
--]]
