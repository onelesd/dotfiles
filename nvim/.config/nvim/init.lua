require('keymaps')
require('plugins')
vim.g.neovide_cursor_vfx_mode = 'pixiedust'
vim.g.gitblame_enabled = 0
vim.g.gitblame_date_format = '%r • %a %b %d %Y %I:%M%p'
vim.g.gitblame_message_template = ' [<author> @ <date> • <summary>]'
-- vim.api.nvim_exec([[set guifont=Iosevka\ Nerd\ Font:h14]], false)
vim.api.nvim_exec([[set guifont=JetBrainsMono\ Nerd\ Font:h13]], false)

vim.opt.termguicolors = true
vim.opt.syntax = 'off'
vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.mouse = 'a'
vim.opt.sessionoptions =
    'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.g.cursorline_timeout = 300
vim.opt.shortmess = 'filnxtToOFc'
vim.opt.signcolumn = 'number'
