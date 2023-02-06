require("keymaps")
require("plugins")

vim.g.floaterm_opener = "drop" -- opens buffer if already open
vim.g.gitblame_enabled = 0
vim.g.gitblame_date_format = "%r • %a %b %d %Y %I:%M%p"
vim.g.gitblame_message_template = " [<author> @ <date> • <summary>]"
vim.api.nvim_exec([[set guifont=JetBrainsMono\ Nerd\ Font:h13]], false)

-- i really like cursorcolumn but it makes screen drawing so laggy
vim.cmd([[
  augroup CursorLine
      au!
      au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
      au WinLeave * setlocal nocursorline

      " au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
      " au WinLeave * setlocal nocursorcolumn
  augroup END
]])

-- neovim 0.8 added smarts to avoid spellchecking code, but it still shows string literals as being misspelled which is annoying for things like import statements
vim.opt.spell = false
-- vim.opt.splitkeep = "screen" -- screen, topline or cursor this keeps the document position where you want it when opening splits
vim.opt.laststatus = 3
vim.opt.showtabline = 1
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
vim.opt.completeopt = "menuone,noinsert,noselect"
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
vim.opt.mouse = nil
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.g.cursorline_timeout = 300
vim.opt.shortmess = "filnxtToOFc"
vim.opt.signcolumn = "yes:2"

-- folding
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'foldexpr=nvim_treesitter#foldexpr()'
-- vim.opt.nofoldenable = true

-- undercurl ansi chars. i guess this isn't needed anymore?
vim.cmd([[
" let &t_Cs = "\e[4:3m"
" let &t_Ce = "\e[4:0m"
" let &t_AU = "\e[58:5:%dm"               " set underline color (ANSI)
" let &t_8u = "\e[58:2:%lu:%lu:%lum"      " sent underline color (R, G, B)
]])
--(" a text with spellling mistake. check that underline or undercurl are OK")

-- tell vim to map +Esc to <M-e>
-- vim.cmd([[set <M-e>=e]])
