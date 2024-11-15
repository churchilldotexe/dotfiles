return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = 'all',
    auto_install = true,
    --[[
    ensure_installed = {
      -- 'latex',
      'php',
      'blade',
      'phpdoc',
      'php_only',
      'javascript',
      'typescript',
      'css',
      'gitignore',
      'graphql',
      'http',
      'json',
      'scss',
      'sql',
      'vim',
      'lua',
      'astro',
      'bash',
      'c',
      'diff',
      'html',
      'luadoc',
      'regex',
      'markdown',
      'markdown_inline',
      'query',
      'vimdoc',
      'nix',
    },
    --]]

    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gsn',
        node_incremental = 'gsr',
        scope_incremental = 'gsc',
        node_decremental = 'gsm',
      },
    },
    textobjects = { -- 'nvim-treesitter/nvim-treesitter-textobjects',
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
          ['ic'] = '@class.inner',
          ['ac'] = '@class.outer',
          ['il'] = '@loop.inner',
          ['al'] = '@loop.outer',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
        },
      },
    },
  },
  config = function(_, opts)
    local map = require('tingexe.util').map
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

    -- vim.filetype.add { pattern = { ['.*%.blade.php'] = 'blade' } }

    -- require('nvim-treesitter.configs').setup(opts)

    parser_config.blade = {
      install_info = {
        url = 'https://github.com/EmranMR/tree-sitter-blade',
        -- url = '~/sources/treesitter/tree-sitter-blade',
        files = { 'src/parser.c' },
        generate_requires_npm = true,
        requires_generate_from_grammar = true,
        branch = 'main',
      },

      filetype = 'blade',
    }

    require('nvim-treesitter.configs').setup(opts)

    map('n', '<leader>ct', vim.treesitter.inspect_tree, { desc = '[C]heck [T]reesitter' })
    map('n', '<leader>ci', vim.show_pos, { desc = '[C]heck [I]nspect ' })
  end,
  dependencies = {
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'LiadOz/nvim-dap-repl-highlights',
  },

  --
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
