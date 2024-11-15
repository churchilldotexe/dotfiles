return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts = opts or {}

    -- LSP override options
    opts.lsp = opts.lsp or {}
    opts.lsp.override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    }

    -- Routes configuration
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    })

    -- Additional route for "No information available"
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })

    -- try hiding phpactor scans
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        find = "scanned 0 reference(s)",
      },
      opts = { skip = true },
    })

    -- Focus-aware notifications
    local focused = true
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function() focused = true end,
    })
    vim.api.nvim_create_autocmd("FocusLost", {
      callback = function() focused = false end,
    })
    table.insert(opts.routes, 1, {
      filter = {
        cond = function() return not focused end,
      },
      view = "notify_send",
      opts = { stop = false },
    })

    -- Presets
    opts.presets = opts.presets or {}
    opts.presets.bottom_search = true
    opts.presets.command_palette = true
    opts.presets.long_message_to_split = true
    opts.presets.lsp_doc_border = true

    -- Commands configuration
    opts.commands = {
      all = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    }

    -- Configuration to show keys and macro status
    opts.views = opts.views or {}
    opts.views.cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    }
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        kind = { "echo", "echomsg" },
      },
      opts = { skip = false },
    })

    -- Ensure macro recording messages are always visible
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        kind = "search_count",
      },
      opts = { skip = false },
    })

    return opts
  end,
  keys = {
    { "<leader>sn", "", desc = "+noice" },
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    {
      "<leader>snl",
      function() require("noice").cmd "last" end,
      desc = "Noice Last Message",
    },
    {
      "<leader>snh",
      function() require("noice").cmd "history" end,
      desc = "Noice History",
    },
    {
      "<leader>sna",
      function() require("noice").cmd "all" end,
      desc = "Noice All",
    },
    {
      "<leader>snd",
      function() require("noice").cmd "dismiss" end,
      desc = "Dismiss All",
    },
    {
      "<leader>snt",
      function() require("noice").cmd "pick" end,
      desc = "Noice Picker (Telescope/FzfLua)",
    },
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then return "<c-f>" end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then return "<c-b>" end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Backward",
      mode = { "i", "n", "s" },
    },
  },
  config = function(_, opts)
    -- HACK: Clear messages when Lazy is installing plugins
    if vim.o.filetype == "lazy" then vim.cmd [[messages clear]] end
    require("noice").setup(opts)

    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })
    local focused = true
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function() focused = true end,
    })
    vim.api.nvim_create_autocmd("FocusLost", {
      callback = function() focused = false end,
    })
    table.insert(opts.routes, 1, {
      filter = {
        cond = function() return not focused end,
      },
      view = "notify_send",
      opts = { stop = false },
    })

    opts.commands = {
      all = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    }

    opts.presets.lsp_doc_border = true
  end,
}
