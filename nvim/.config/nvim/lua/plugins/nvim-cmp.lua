return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji", "Gelio/cmp-natdat" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, { name = "emoji" })
    table.insert(opts.sources, { name = "natdat" })
  end,
}
