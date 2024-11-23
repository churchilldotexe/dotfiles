return {
  "nvim-neotest/neotest",
  -- opts will be merged with the parent spec
  opts = function(_, opts)
    -- get existing adapters (if any)
    opts.adapters = opts.adapters or {}
    -- add additional adapters
    table.insert(opts.adapters, require "neotest-pest")
    return opts
  end,
  -- Add the adapter plugin to dependencies
  dependencies = {
    "V13Axel/neotest-pest",
  },
}
