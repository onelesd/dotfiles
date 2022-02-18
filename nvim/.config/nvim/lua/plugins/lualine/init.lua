require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', {'diagnostics', sources = {'nvim_lsp'}}},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  },
  extensions = {'quickfix'}
}
