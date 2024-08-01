-- local map_utils = require("plugins/util/map_utils")

-- create some keymaps that use expressions
-- someday figure out how to load these in the keymaps_table instead
local select_ease = require("SelectEase")

local lua_query = [[
      ;; query
      ((identifier) @cap)
      ("string_content" @cap)
      ((true) @cap)
      ((false) @cap)
  ]]
local typescript_query = [[
      ;; query
      ((identifier) @cap)
      ((property_identifier) @cap)
      ((type_identifier) @cap)
      ((shorthand_property_identifier) @cap)
      ((shorthand_property_identifier_pattern) @cap)
      ((predefined_type) @cap)
      ((string) @cap)
      ((string_fragment) @cap)
      ((number) @cap)
      ((true) @cap)
      ((false) @cap)
  ]]
local json_query = [[
      ;; query
      ("string_content" @cap)
  ]]

local queries = {
	lua = lua_query,
	typescript = typescript_query,
	-- json = json_query, -- this generates errors when trying to navigate...
}
vim.keymap.set({ "n", "s", "i" }, "<S-Left>", function()
	select_ease.select_node({ queries = queries, direction = "previous" })
end, {})
vim.keymap.set({ "n", "s", "i" }, "<S-Right>", function()
	select_ease.select_node({ queries = queries, direction = "next" })
end, {})
-- S-UP and S-DOWN are not working for some reason
-- vim.keymap.set({ "n", "s", "i" }, "<S-Up>", function()
-- 	select_ease.select_node({
-- 		queries = queries,
-- 		direction = "previous",
-- 		vertical_drill_jump = true,
-- 	})
-- end, {})
-- vim.keymap.set({ "n", "s", "i" }, "<S-Down>", function()
-- 	select_ease.select_node({
-- 		queries = queries,
-- 		direction = "next",
-- 		vertical_drill_jump = true,
-- 	})
-- end, {})

local term_base = "<CMD>hi FloatermBorder guifg=#24283b<CR>"
	.. "<CMD>FloatermKill!<CR>"
	.. "<CMD>FloatermNew --width=0.9 --height=0.9 "
	.. "--borderchars="
	.. table.concat(require("plugins/util").borderchars)
	.. " "
	.. "--autoclose="
local term_base_shell = "<CMD>hi FloatermBorder guifg=#24283b<CR>"
	.. "<CMD>FloatermKill!<CR>"
	.. "<CMD>FloatermNew! --width=0.25 --height=0.75 "
	.. "--borderchars="
	.. table.concat(require("plugins/util").borderchars)
	.. " "
	.. "--autoclose="

local dotfiles = "~/dotfiles/nvim/.config/nvim"

function _G.delete_unmodified_hidden_buffers()
	local all_buffers = vim.api.nvim_list_bufs()
	local visible_buffers = {}

	for _, win_id in ipairs(vim.api.nvim_list_wins()) do
		local buf_id = vim.api.nvim_win_get_buf(win_id)
		visible_buffers[buf_id] = true
	end

	for _, buf_id in ipairs(all_buffers) do
		if not visible_buffers[buf_id] then
			local buf_modified = vim.api.nvim_buf_get_option(buf_id, "modified")
			if not buf_modified then
				vim.api.nvim_buf_delete(buf_id, { force = true })
			end
		end
	end

	vim.notify("Removed all non-visible buffers.")
end

local keymaps_table = {
	{ "n", ";", ":" }, -- less shift pressing please
	{ "n", "<ESC>", "<CMD>noh<CR><ESC>" }, -- clear search on enter
	{ "n", "s", "<C-w>" }, -- move windows with s
	{ "n", "<C-w>", "" }, -- disable move winndows with <C-w> so we learn to use s

	{ "v", "y", "ygv<ESC>" }, -- disable move winndows with <C-w> so we learn to use s

	-- expert mode
	-- {'n', '<UP>', '<C-w><UP>'}, -- k
	-- {'n', '<DOWN>', '<C-w><DOWN>'}, -- j
	-- {'n', '<LEFT>', '<C-w><LEFT>'}-- h
	-- {'n', '<RIGHT>', '<C-w><RIGHT>'}, -- l

	-- <C-\\> system clipboard paste because CMD-anything doesn't work in neovide
	{ "n", "<C-\\>", "<CMD>set paste<CR>a<C-r>+<ESC><CMD>set nopaste<CR>" },
	{ "i", "<C-\\>", "<C-o><CMD>set paste<CR><C-r>+<C-o><CMD>set nopaste<CR>" },
	{ "n", "<leader>c", '"+ye' },
	{ "v", "<leader>c", '"+y' },

	{ "n", "-", "<CMD>lua require('oil').open()<CR>" }, -- open file browser

	-- we like both gl and C-space for diagnostic float
	{ "n", "gl", '<CMD>lua vim.diagnostic.open_float(nil, {focus = false, border = "single"})<CR>' },
	{ "n", "<C-Space>", '<CMD>lua vim.diagnostic.open_float(nil, {focus = false, border = "single"})<CR>' },
	{ "n", "[d", '<CMD>lua vim.diagnostic.goto_prev({float = {focus = false, border = "single"}})<CR>' },
	{ "n", "]d", '<CMD>lua vim.diagnostic.goto_next({float = {focus = false, border = "single"}})<CR>' },

	-- telescope stuff
	{ "n", "<leader><leader>", '<CMD>lua require("plugins/util").telescope_find_files()<CR>' },
	{ "n", "<leader>bb", '<CMD>lua require("plugins/util").telescope_buffers()<CR>' },
	{ "n", "<leader>sp", '<CMD>lua require("plugins/util").telescope_live_grep()<CR>' },
	{ "v", "<leader>sp", '"zy<CMD>lua require("plugins/util").telescope_live_grep(vim.fn.getreg("z"))<CR>qzq' },
	{ "n", "<leader>sd", '<CMD>lua require("plugins/util").telescope_live_grep_in_folder()<CR>' },
	{ "n", "<leader>rr", "<CMD>Telescope resume<CR>" },
	{
		"v",
		"<leader>sd",
		'"zy<CMD>lua require("plugins/util").telescope_live_grep_in_folder(vim.fn.getreg("z"))<CR>qzq',
	},
	{ "n", "<leader>sf", '<CMD>lua require("plugins/util").telescope_current_buffer_fuzzy_find()<CR>' },
	{
		"v",
		"<leader>sf",
		'"zy<CMD>lua require("plugins/util").telescope_current_buffer_fuzzy_find(vim.fn.getreg("z"))qzq<CR>',
	},
	{ "n", "<leader>hh", '<CMD>lua require("plugins/util").telescope_help_tags()<CR>' },
	{ "n", "<leader>pp", '<CMD>lua require("plugins/util").telescope_project()<CR>' },
	{ "n", "<leader>rf", '<CMD>lua require("plugins/util").telescope_recent()<CR>' },

	-- center window on search term when searching
	{ "n", "n", "nzzzv" },
	{ "n", "N", "Nzzzv" },
	-- this expression isn't being evaluated correctly and prevcents :commands from running
	-- {
	-- 	"c",
	-- 	"<CR>",
	-- 	map_utils.lua_expr(function()
	-- 		return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
	-- 	end),
	-- 	{ expr = true },
	-- },
	-- { "n", "p", "]p" }, -- paste respecting indentation level

	-- slime repl
	-- {'n', '<leader>ix', '<CMD>tabnew ~/tmp/neovim_iex.exs<CR><CMD>vsplit term://iex -S mix<CR><C-w>w'},
	-- {"n", "<leader>iX", "<C-w><RIGHT><CMD>bdelete!<CR>A<C-c><C-c><CMD>sleep 100m<CR><C-c>"},

	-- elixir mix
	-- {'n', '<leader>md', '<CMD>lua require("plugins/util").mix_latest()<CR>'},
	-- {'n', '<leader>mt', term_base .. '0 mix test<CR>'},
	-- {'n', '<leader>mf', term_base .. '0 mix test %<CR>'},
	-- {'n', '<leader>mF', '<CMD>lua require("plugins/util").mix_test_line()<CR>'},

	-- git
	{ "n", "<leader>gb", "<CMD>GitBlameToggle<CR>" },
	{
		"n",
		"<leader>go",
		'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
	},

	-- commented due to lack of use
	-- {"n", "<leader>e", "<CMD>Texplore .<CR>"}, -- explore in a new tab

	{ "n", "<leader>sa", '<CMD>lua require("plugins/util").saveas()<CR>' }, -- save a copy of current file in same dir

	-- treesitter
	{ "n", "<C-l>", "<CMD>TSBufDisable highlight<CR><CMD>TSBufEnable highlight<CR>" },

	-- navigate tab-like for buffers
	{ "n", "<leader>gx", "<CMD>tabclose<CR>" },
	{ "n", "<leader>bx", "<CMD>Bdelete<CR>" },
	{ "n", "<TAB>", "<C-W><C-W>" },
	{ "n", "<leader>bo", "<CMD>lua delete_unmodified_hidden_buffers()<CR>" }, -- remove all hidden buffers

	{ "n", "<leader>z", "<CMD>lua require('zen-mode').toggle({ window = { width = 0.75, height = 0.98 } })<CR>" }, -- zen mode

	-- lazygit
	-- { "n", "<leader>t", term_base .. "1 /bin/zsh<CR>" },
	{ "n", "<leader>gg", term_base .. "1 lazygit<CR>" },
	-- { "n", "<leader>gg", "<CMD>LazyGit<CR>" },

	-- local term_base = "<CMD>hi FloatermBorder guifg=#24283b<CR>"
	-- 	.. "<CMD>FloatermKill!<CR>"
	-- 	.. "<CMD>FloatermNew --width=0.9 --height=0.9 "
	-- 	.. "--borderchars="
	-- 	.. table.concat(require("plugins/util").borderchars)
	-- 	.. " "
	-- 	.. "--autoclose="
	-- vim.api.nvim_command(term_base .. "1 rush build --to=nvs-" .. parts[2] .. "<CR>")

	-- rush
	{
		"n",
		"<leader>rt",
		term_base_shell
			.. "2 rushtofromvim % ; echo Press \\[Enter\\] to quit or \\[Ctrl-C\\] to inspect; read && exit<CR>",
	},

	-- lsp
	-- {'n', 'gd', '<CMD>lua require"telescope.builtin".lsp_definitions()<CR>'},
	-- {'n', 'gr', '<CMD>lua require"telescope.builtin".lsp_references()<CR>'},
	{ "n", "<leader>l", "<CMD>LspRestart<CR>" },
	{ "n", "gd", "<CMD>Lspsaga finder def+tyd+ref+imp<CR>" },
	-- { "n", "gT", "<CMD>Lspsaga goto_type_definition<CR>" },
	{ "n", "gs", "<CMD>TypescriptGoToSourceDefinition<CR>" },
	{ "n", "gp", "<CMD>Lspsaga peek_definition<CR>" },
	{ "n", "ga", "<CMD>Lspsaga code_action<CR>" },
	{ "n", "<leader>o", "<CMD>lua require('nvim-navbuddy').open()<CR>" },
	{ "n", "<leader>d", "<CMD>Trouble document_diagnostics<CR>" },
	{ "n", "<leader>D", "<CMD>Trouble workspace_diagnostics<CR>" },
	{ "n", "<leader>xd", "<CMD>lua vim.diagnostic.reset()<CR>" },
	{ "n", "<leader>t", "<CMD>Trouble<CR>" },
	{ "n", "<leader>T", "<CMD>TroubleRefresh<CR>" },
	{ "n", "<leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>" },
	{ "n", "<leader>i", "<CMD>TypescriptAddMissingImports<CR>" },
	{ "n", "<leader>I", "<CMD>TypescriptOrganizeImports<CR>" },
	{ "n", "<leader>td", "<CMD>TodoTelescope<CR>" },
	{ "n", "K", "<CMD>Lspsaga hover_doc<CR>" },
	{
		"n",
		"<leader>k",
		'<CMD>lua require"dash.providers.telescope".dash({ bang = true, initial_text = vim.fn.expand("<cword>") })<CR>',
	}, -- dash integration
	{ "n", "<leader>hd", "<CMD>lua require('elixir-extras').elixir_view_docs({include_mix_libs=true})<CR>" },

	-- open Copilot suggestions
	-- { "i", "<C-c>", "<CMD>lua require('copilot.suggestion').next()<CR>" },
	-- { "i", "<C-v>", "<CMD>lua require('copilot.suggestion').accept()<CR>" },

	-- open/close vim configs
	{
		"n",
		"<leader>v",
		"<CMD>tabnew "
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
			.. "/lua/plugins<CR>",
	},
	{ "n", "<leader>V", "<CMD>bdelete<CR><CMD>bdelete<CR><CMD>bdelete<CR><CMD>bdelete<CR>" },

	-- customize mouse
	{ "n", "<LeftDrag>", "" },
	{ "n", "<LeftRelease>", "" },
}

-- create keymaps from table
for _, k in ipairs(keymaps_table) do
	local mode, key, cmd, opts = unpack(k)
	if opts then
		vim.api.nvim_set_keymap(mode, key, cmd, opts)
	else
		vim.api.nvim_set_keymap(mode, key, cmd, { noremap = true, silent = true, expr = false })
	end
end
