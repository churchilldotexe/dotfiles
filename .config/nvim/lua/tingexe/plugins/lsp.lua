return {

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},

        marksman = {
          cmd = { 'marksman', 'server' },
          filetypes = { 'markdown', 'markdown.mdx' },
          root_dir = function(...)
            return require('lspconfig.util').root_pattern('.marksman.toml', '*.mdx', '*.md')(...)
          end,
          single_file_support = true,
        },
        phpactor = {
          cmd = { 'phpactor', 'language-server' },
          filetypes = { 'php' },
          root_dir = function(...)
            return require('lspconfig.util').root_pattern('composer.json', '*.php', '.git')(...)
          end,
        },

        intelephense = {
          cmd = { 'intelephense', '--stdio' },
          filetypes = { 'php' },
          root_dir = function(...)
            return require('lspconfig.util').root_pattern('composer.json', '*.php', '.git')(...)
          end,
        },

        eslint = {
          cmd = { 'vscode-eslint-language-server', '--stdio' },
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue', 'svelte', 'astro' },
          settings = {
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = 'separateLine',
              },
              showDocumentation = {
                enable = true,
              },
            },
            codeActionOnSave = {
              enable = false,
              mode = 'all',
            },
            format = true,
            nodePath = '',
            onIgnoredFiles = 'off',
            problems = {
              shortenToSingleLine = false,
            },
            quiet = false,
            rulesCustomizations = {},
            run = 'onType',
            validate = 'on',
            workingDirectory = {
              mode = 'location',
            },
          },
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },

        astro = {
          cmd = { 'astro-ls', '--stdio' },
          filetypes = { 'astro' },
          init_options = {
            typescript = {},
          },
          root_dir = function(...)
            return require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(...)
          end,
        },
        tailwindcss = {
          cmd = { 'tailwindcss-language-server', '--stdio' },
          root_dir = function(...)
            return require('lspconfig.util').root_pattern(
              'tailwind.config.js',
              'tailwind.config.cjs',
              'tailwind.config.mjs',
              'tailwind.config.ts',
              'postcss.config.js',
              'postcss.config.cjs',
              'postcss.config.mjs',
              'postcss.config.ts',
              'package.json',
              'node_modules',
              '.git'
            )(...)
          end,
          filetypes = {
            'aspnetcorerazor',
            'astro',
            'astro-markdown',
            'blade',
            'clojure',
            'django-html',
            'htmldjango',
            'edge',
            'eelixir',
            'elixir',
            'ejs',
            'erb',
            'eruby',
            'gohtml',
            'gohtmltmpl',
            'haml',
            'handlebars',
            'hbs',
            'html',
            'htmlangular',
            'html-eex',
            'heex',
            'jade',
            'leaf',
            'liquid',
            'markdown',
            'mdx',
            'mustache',
            'njk',
            'nunjucks',
            'php',
            'razor',
            'slim',
            'twig',
            'css',
            'less',
            'postcss',
            'sass',
            'scss',
            'stylus',
            'sugarss',
            'javascript',
            'javascriptreact',
            'reason',
            'rescript',
            'typescript',
            'typescriptreact',
            'vue',
            'svelte',
            'templ',
          },
          settings = {
            tailwindCSS = {
              classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
              includeLanguages = {
                eelixir = 'html-eex',
                eruby = 'erb',
                htmlangular = 'html',
                templ = 'html',
              },
              lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidConfigPath = 'error',
                invalidScreen = 'error',
                invalidTailwindDirective = 'error',
                invalidVariant = 'error',
                recommendedVariantOrder = 'warning',
              },
              validate = true,
            },
          },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'phpcs',
        'pint',
        'phpactor',
        'php-cs-fixer',
        'astro-language-server',
        -- 'eslint',
        'eslint_d',
        -- 'eslint-lsp',
        'lua-language-server',
        'cssls',
        'css_variables',
        'cssmodules_ls',
        'lua_ls',
        'markdown-oxide',
        'mdx-analyzer',
        'markdownlint',
        'markdownlint-cli2',
        'markdown-toc',
        'prettierd',
        'prettier',
        'biome',
        'prismals',
        'tailwindcss-language-server',
        'biome',
        -- 'emmet-ls',
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end
    end,
  },

  { -- Autoformat
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

      -- default_format_opts = {
      --   timeout_ms = 3000,
      --   async = false, -- not recommended to change
      --   quiet = false, -- not recommended to change
      --   lsp_format = 'fallback', -- not recommended to change
      -- },
      notify_on_error = false,
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
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        --
        --
        php = { 'pint', 'php_cs_fixer', stop_after_first = true },
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
    },
  },
}
