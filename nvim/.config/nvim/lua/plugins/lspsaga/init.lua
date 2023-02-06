require("lspsaga").setup({
	server_filetype_map = {
		typescript = "typescript",
	},
	finder = {
		edit = { "<CR>" },
		vsplit = "v",
		split = "s",
		tabe = "t",
		quit = { "q", "<ESC>" },
	},
	lightbulb = {
		enable = false,
		enable_in_insert = false,
		sign = false,
		sign_priority = 40,
		virtual_text = false,
	},
})

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
