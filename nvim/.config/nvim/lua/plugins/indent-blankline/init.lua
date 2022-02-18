-- basic guides ----------------------
-- vim.g.indentLine_char_list = {'¦'}
-- require('indent_blankline').setup {
-- }
-- -----------------------------------
-- alternating color columns ---------
-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#252a33 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#20242d gui=nocombine]]
-- require('indent_blankline').setup {
--   char = '',
--   char_highlight_list = {'IndentBlanklineIndent1', 'IndentBlanklineIndent2'},
--   space_char_highlight_list = {
--     'IndentBlanklineIndent1', 'IndentBlanklineIndent2'
--   },
--   show_trailing_blankline_indent = false
-- }
-- -----------------------------------
-- treesitter context ----------------
vim.opt.list = true
vim.opt.listchars:append('space: ')
vim.g.indentLine_char_list = {'⋮'}

require('indent_blankline').setup {
  space_char_blankline = ' ',
  show_current_context = false,
  show_current_context_start = false
}
-- -----------------------------------
