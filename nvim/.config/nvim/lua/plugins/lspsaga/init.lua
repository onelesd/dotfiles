require('lspsaga').init_lsp_saga {
  server_filetype_map = {
    typescript = 'typescript'
  }
}

-- allow ESC to close lspsaga windows
vim.cmd([[
  augroup lspsaga_filetypes
    autocmd!
    autocmd FileType LspsagaCodeAction,LspsagaFinder,LspsagaRename nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  augroup END
]])
-- LspsagaCodeAction
-- LspsagaDiagnostic
-- LspsagaFinder
-- LspsagaFloaterm
-- LspsagaHover
-- LspsagaRename
-- LspsagaSignatureHelp
