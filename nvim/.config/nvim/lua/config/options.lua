-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local g = vim.g

opt.wrap = true
opt.textwidth = 78
opt.conceallevel = 0

if g.neovide then
  opt.guifont = "JetBrainsMono Nerd Font:h18" -- neovide font rendering runs small
  g.neovide_cursor_vfx_mode = "pixiedust"
end
