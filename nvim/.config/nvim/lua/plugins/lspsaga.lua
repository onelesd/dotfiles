return {
  {
    "nvimdev/lspsaga.nvim",
    keys = {
      { "gd", "<CMD>Lspsaga finder def+tyd+ref+imp<CR>" },
      { "gp", "<CMD>Lspsaga peek_definition<CR>" },
    },
    opts = {
      finder = {
        layout = "float", -- float, normal
        keys = {
          edit = { "<CR>" },
          vsplit = "v",
          split = "s",
          quit = { "q", "<ESC>" },
          shuttle = "<S-tab>",
        },
      },
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
      },
    },
  },
}
