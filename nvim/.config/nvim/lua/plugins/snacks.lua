return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = {
        formatters = {
          file = {
            truncate = 120,
          },
        },
        matcher = {
          frecency = true,
        },
        keys = {
          -- reverse some of the default picker heymaps to use root dir instead of cwd
          { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
          { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
          { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
          { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        },
      },
    },
  },
}
