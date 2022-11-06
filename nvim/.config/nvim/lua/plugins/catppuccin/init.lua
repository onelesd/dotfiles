vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
require('catppuccin').setup {
  styles = {
    comments = "italic", -- Style that is applied to comments: see `highlight-args` for options
    diagnostics = "undercurl", -- Style that is applied to diagnostics: see `highlight-args` for options
  },
  custom_styles = {
    LspDiagnosticsUnderlineError = "undercurl",
  }
}
