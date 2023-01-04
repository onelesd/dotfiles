local opts = { noremap = true, silent = true, expr = false }
-- local expr_opts = {noremap = true, silent = true, expr = true}
local map = vim.api.nvim_set_keymap

vim.g.mapleader = " " -- what is this, spacemacs?
map("n", ";", ":", opts) -- less shift pressing please
map("n", "<CR>", ":noh<CR><CR>", opts) -- clear search on enter

-- expert mode
-- map('n', '<UP>', '<C-w><UP>', opts) -- k
-- map('n', '<DOWN>', '<C-w><DOWN>', opts) -- j
-- map('n', '<LEFT>', '<C-w><LEFT>', opts) -- h
-- map('n', '<RIGHT>', '<C-w><RIGHT>', opts) -- l

-- easy move between windows
-- map('n', '<Backspace>', '<C-w><C-w>', opts)

-- <C-p> system clipboard paste because CMD-anything doesn't work in neovide
map("n", "<C-\\>", "<CMD>set paste<CR>a<C-r>+<ESC><CMD>set nopaste<CR>", opts)
map("i", "<C-\\>", "<C-o><CMD>set paste<CR><C-r>+<C-o><CMD>set nopaste<CR>", opts)

map("n", "gl", '<CMD>lua vim.diagnostic.open_float(nil, {focus = false, border = "single"})<CR>', opts)
map("n", "[d", '<CMD>lua vim.diagnostic.goto_prev({float = {focus = false, border = "single"}})<CR>', opts)
map("n", "]d", '<CMD>lua vim.diagnostic.goto_next({float = {focus = false, border = "single"}})<CR>', opts)

-- telescope stuff
map("n", "<leader><leader>", '<CMD>lua require("plugins/util").telescope_find_files()<CR>', opts)
map("n", "<leader>bb", '<CMD>lua require("plugins/util").telescope_buffers()<CR>', opts)
map("n", "<leader>sp", '<CMD>lua require("plugins/util").telescope_live_grep()<CR>', opts)
map("v", "<leader>sp", '"zy<CMD>lua require("plugins/util").telescope_live_grep(vim.fn.getreg("z"))<CR>qzq', opts)
map("n", "<leader>sP", '<CMD>lua require("plugins/util").telescope_live_grep_in_folder()<CR>', opts)
map(
	"v",
	"<leader>sP",
	'"zy<CMD>lua require("plugins/util").telescope_live_grep_in_folder(vim.fn.getreg("z"))<CR>qzq',
	opts
)
map("n", "<leader>sf", '<CMD>lua require("plugins/util").telescope_current_buffer_fuzzy_find()<CR>', opts)
map(
	"v",
	"<leader>sf",
	'"zy<CMD>lua require("plugins/util").telescope_current_buffer_fuzzy_find(vim.fn.getreg("z"))qzq<CR>',
	opts
)
map("n", "<leader>hh", '<CMD>lua require("plugins/util").telescope_help_tags()<CR>', opts)
map("n", "<leader>pp", '<CMD>lua require("plugins/util").telescope_project()<CR>', opts)
map("n", "<leader>rf", '<CMD>lua require("plugins/util").telescope_recent()<CR>', opts)

-- center window on search term when searching
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
vim.keymap.set("c", "<CR>", function()
	return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true })

-- map('n', '<leader>ix',
--     '<CMD>tabnew ~/tmp/neovim_iex.exs<CR><CMD>vsplit term://iex -S mix<CR><C-w>w',
--     opts)
map("n", "<leader>iX", "<C-w><RIGHT><CMD>bdelete!<CR>A<C-c><C-c><CMD>sleep 100m<CR><C-c>", opts)

-- map('n', '<leader>md', '<CMD>lua require("plugins/util").mix_latest()<CR>', opts)

map("n", "<leader>gb", "<CMD>GitBlameToggle<CR>", opts)
map(
	"n",
	"<leader>go",
	'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
	opts
)

-- map('n', '<leader>pi',
--     '<CMD>source ~/.config/nvim/lua/plugins/init.lua<CR><CMD>PackerCompile<CR><CMD>PackerInstall<CR>',
--     opts)
-- map('n', '<leader>pc',
--     '<CMD>source ~/.config/nvim/lua/plugins/init.lua<CR><CMD>PackerCompile<CR><CMD>PackerClean<CR>',
--     opts)
map("n", "<leader>e", "<CMD>Texplore .<CR>", opts)

-- save a copy of current file in same dir
map("n", "<leader>sa", '<CMD>lua require("plugins/util").saveas()<CR>', opts)

-- navigate tab-like for buffers
map("n", "<leader>gx", "<CMD>tabclose<CR>", opts)
map("n", "<leader>bx", "<CMD>Bdelete<CR>", opts)
map("n", "<TAB>", "<C-W><C-W>", opts)
map("n", "<leader>bo", "<CMD>%bd|e#|bd#<CR>", opts) -- kill all other buffers
map("n", "<leader>z", "<CMD>lua require('zen-mode').toggle({ window = { width = 0.35 } })<CR>", opts)
map("n", "<leader>Z", "<CMD>Twilight<CR>", opts)

-- pretend we're magit
local term_base = "<CMD>hi FloatermBorder guifg=#24283b<CR>"
	.. "<CMD>FloatermNew --width=0.9 --height=0.9 "
	.. "--borderchars="
	.. table.concat(require("plugins/util").borderchars)
	.. " "
	.. "--autoclose="
-- .. '--borderchars=─│─│╭╮╯╰ '
map("n", "<leader>t", term_base .. "1 /bin/zsh<CR>", opts)
map("n", "<leader>gg", term_base .. "1 lazygit<CR>", opts)

-- mix tests
-- map('n', '<leader>mt', term_base .. '0 mix test<CR>', opts)
-- map('n', '<leader>mf', term_base .. '0 mix test %<CR>', opts)
-- map('n', '<leader>mF', '<CMD>lua require("plugins/util").mix_test_line()<CR>',
--     opts)

-- common code-related doings
-- map('n', 'gd', '<CMD>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
map("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
-- map('n', 'gr', '<CMD>lua require"telescope.builtin".lsp_references()<CR>', opts)
map("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
map("n", "ga", "<Cmd>Lspsaga code_action<CR>", opts)
map("n", "<leader>d", "<CMD>Trouble document_diagnostics<CR>", opts)
map("n", "<leader>D", "<CMD>Trouble workspace_diagnostics<CR>", opts)
map("n", "<leader>xd", "<CMD>lua vim.diagnostic.reset()<CR>", opts)
map("n", "<leader>T", "<CMD>Trouble<CR>", opts)
map("n", "<leader>rn", '<CMD>lua require"lspsaga.rename".rename()<CR>', opts)

-- show doc for symbol
-- map('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
map("n", "K", "<CMD>Lspsaga hover_doc<CR>", opts)
-- map('v', 'K',
--     '<CMD>lua require"dash.providers.telescope".dash({ bang = false, initial_text = vim.fn.expand("<cword>") })<CR>',
--     opts)

-- open/close vim configs
local dotfiles = "~/dotfiles/nvim/.config/nvim"
local config_edit = "<CMD>tabnew "
	.. dotfiles
	.. "/lua/plugins/init.lua<CR>"
	.. "<CMD>vsplit "
	.. dotfiles
	.. "/lua/keymaps.lua<CR>"
	.. "<CMD>split "
	.. dotfiles
	.. "/init.lua<CR>"
	.. "<C-w><RIGHT><CMD>split<CR><CMD>e "
	.. dotfiles
	.. "/lua/plugins<CR>"
map("n", "<leader>v", config_edit, opts)
map("n", "<leader>vo", config_edit .. "<C-w><LEFT><CR>", opts)
map("n", "<leader>vp", config_edit .. "<C-w><DOWN><CR>", opts)
map("n", "<leader>vk", config_edit .. "<C-w><DOWN><CR><C-w><LEFT><CR>", opts)

map("n", "<leader>V", "<CMD>bdelete<CR><CMD>bdelete<CR><CMD>bdelete<CR><CMD>bdelete<CR>", opts)
