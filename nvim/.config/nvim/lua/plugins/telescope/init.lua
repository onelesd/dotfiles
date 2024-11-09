local actions = require("telescope.actions")
-- vim.cmd("highlight TelescopeBorder guifg=#24283b")
-- vim.cmd("highlight TelescopeBorder guifg=#1f1f28")
-- vim.cmd("highlight TelescopeBorder guifg=#181820")
-- vim.cmd("highlight TelescopeBorder guibg=#181820")
local trouble = require("trouble.sources.telescope")
-- local lga_actions = require("telescope-live-grep-args.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<ESC>"] = actions.close,
				["<C-J>"] = actions.move_selection_next,
				["<C-K>"] = actions.move_selection_previous,
				["<C-t>"] = trouble.open,
				["<S-DOWN>"] = require("telescope.actions").cycle_history_next,
				["<S-UP>"] = require("telescope.actions").cycle_history_prev,
				["<C-?>"] = actions.which_key,
				["<C-v>"] = actions.select_vertical,
				["<C-s>"] = actions.select_horizontal,
			},
			n = {
				["<ESC>"] = actions.close,
				["<C-J>"] = actions.move_selection_next,
				["<C-K>"] = actions.move_selection_previous,
				["<C-t>"] = trouble.open,
				["<S-DOWN>"] = require("telescope.actions").cycle_history_next,
				["<S-UP>"] = require("telescope.actions").cycle_history_prev,
				["<C-?>"] = actions.which_key,
			},
		},
	},
	extensions = {
		-- ['dash'] = {
		-- },
		-- ["zf-native"] = {
		-- 	-- options for sorting file-like items
		-- 	file = {
		-- 		-- override default telescope file sorter
		-- 		enable = true,
		--
		-- 		-- highlight matching text in results
		-- 		highlight_results = true,
		--
		-- 		-- enable zf filename match priority
		-- 		match_filename = true,
		-- 	},
		--
		-- 	-- options for sorting all other items
		-- 	generic = {
		-- 		-- override default telescope generic item sorter
		-- 		enable = true,
		--
		-- 		-- highlight matching text in results
		-- 		highlight_results = true,
		--
		-- 		-- disable zf filename match priority
		-- 		match_filename = false,
		-- 	},
		-- },
		-- live_grep_args = {
		-- 	auto_quoting = true,
		-- 	mappings = {
		-- 		i = {
		-- 			["<C-l>"] = lga_actions.quote_prompt({ postfix = " --glob " }),
		-- 		},
		-- 	},
		-- 	-- ... also accepts theme settings, for example:
		-- 	-- theme = "dropdown", -- use dropdown theme
		-- 	-- theme = { }, -- use own theme spec
		-- 	-- layout_config = { mirror=true }, -- mirror preview pane
		-- },
		smart_open = {
			show_scores = false,
			ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
			match_algorithm = "fzf",
			disable_devicons = false,
		},
	},
})
require("telescope").load_extension("project")
-- require("telescope").load_extension("notify")
require("telescope").load_extension("fzf")
-- require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("smart_open")
-- require('telescope').load_extension('file_browser')
-- require("telescope").load_extension("zf-native")
