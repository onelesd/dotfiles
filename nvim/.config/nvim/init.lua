require("plugins")
require("keymaps")

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h16"
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_underline_automatic_scaling = true
	vim.g.neovide_scroll_animation_length = 0.15

	-- Allow clipboard copy paste in neovim
	vim.g.neovide_input_use_logo = 1
	vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end

-- vim.g.floaterm_opener = "drop" -- opens buffer if already open
vim.g.floaterm_opener = "vsplit" -- opens buffer if already open
vim.g.gitblame_enabled = 0
vim.g.gitblame_date_format = "%r • %a %b %d %Y %I:%M%p"
vim.g.gitblame_message_template = " [<author> @ <date> • <summary>]"

-- set cursorline for current buffer only
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "setlocal cursorline" })
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "setlocal nocursorline" })

-- dim the focused window when neovim itself loses focus so that it plays nicely with wezterm pane dimming
vim.api.nvim_create_autocmd({ "FocusGained" }, { pattern = "*", command = "highlight Normal guibg=#1f1f28" })
vim.api.nvim_create_autocmd({ "FocusLost" }, { pattern = "*", command = "highlight Normal guibg=#181820" })

-- equalize windows when vim is resized
vim.api.nvim_create_autocmd({ "VimResized" }, { pattern = "*", command = "wincmd =" })

-- make mouse support better for switching buffers
-- this causes error on startup and breaks everything
-- vim.api.nvim_create_autocmd({ "BufLeave" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_current_mark("m", vim.api.nvim_win_get_cursor(0))
-- 	end,
-- })
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "m"))
-- 	end,
-- })

-- neovim 0.8 added smarts to avoid spellchecking code, but it still shows string literals as being misspelled which is annoying for things like import statements
vim.opt.spell = false
vim.opt.spelloptions = "camel"
vim.opt.splitkeep = "screen" -- screen, topline or cursor this keeps the document position where you want it when opening splits
vim.g.splitbelow = true
vim.g.splitright = true
vim.opt.laststatus = 0
vim.opt.showtabline = 1
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┨",
	vertright = "┣",
	verthoriz = "╋",
})
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.syntax = "off"
vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
-- vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.mouse = "n"
vim.opt.mousehide = true
vim.opt.mousefocus = true -- this doesn't seem to work in terminal
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.g.cursorline_timeout = 300
vim.opt.shortmess = "filnxtToOFc"
vim.opt.signcolumn = "yes:2"
vim.opt.pumblend = 30

-- folding
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'foldexpr=nvim_treesitter#foldexpr()'
-- vim.opt.nofoldenable = true
