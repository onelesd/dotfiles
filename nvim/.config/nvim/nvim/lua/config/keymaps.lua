-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "s", "<C-w>")
map("n", ";", ":")
map("n", "<ESC>", "<CMD>noh<CR><ESC>")
map("n", "<leader>z", "<CMD>ZenMode<CR>")
