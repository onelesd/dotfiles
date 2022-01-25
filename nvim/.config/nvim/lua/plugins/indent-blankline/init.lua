-- vim.g.indentLine_char_list = {'¦'}
-- require('indent_blankline').setup {
-- }
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#252a33 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#20242d gui=nocombine]]

require('indent_blankline').setup {
  char = '',
  char_highlight_list = {'IndentBlanklineIndent1', 'IndentBlanklineIndent2'},
  space_char_highlight_list = {
    'IndentBlanklineIndent1', 'IndentBlanklineIndent2'
  },
  show_trailing_blankline_indent = false
}
