-- this makes treesitter resync the buffer highlighting since it seems to get out of sync with neovim 0.9.2
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "TextChanged" }, {
	pattern = "*",
	command = "TSBufDisable highlight | TSBufEnable highlight",
})

require("nvim-treesitter.configs").setup({
	-- "all", "maintained", or a list of languages
	ensure_installed = { "json", "toml", "yaml", "typescript", "elixir", "regex", "markdown", "markdown_inline", "bash" },

	-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#adding-support-for-more-languages
	context_commentstring = {
		enable = true,
	},

	textobjects = {
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
			},
		},
	},

	textsubjects = {
		enable = true,
		-- prev_selection = ',', -- (Optional) keymap to select the previous selection
		keymaps = {
			["."] = "textsubjects-smart",
			-- [';'] = 'textsubjects-container-outer',
			-- ['i;'] = 'textsubjects-container-inner',
		},
	},

	-- if you get diagnostics errors about an unclosed tag that won't go away
	-- see here: https://github.com/windwp/nvim-ts-autotag#enable-update-on-insert
	autotag = {
		enable = true,
	},

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	sync_install = false,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- disable = {'lua'},

		additional_vim_regex_highlighting = false,
	},

	-- experimental
	indent = {
		enable = true,
	},

	matchup = {
		enable = false, -- mandatory, false will disable the whole extension
		disable = {}, -- optional, list of language that will be disabled
	},

	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = false },
		-- smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
		-- navigation = {
		--   enable = true,
		--   keymaps = {
		--     goto_definition = "gnd",
		--     list_definitions = "gnD",
		--     list_definitions_toc = "gO",
		--     goto_next_usage = "<a-*>",
		--     goto_previous_usage = "<a-#>",
		--   },
		-- },
		-- textobjects = {
		--   lsp_interop = {
		--     enable = true,
		--     border = 'none',
		--     peek_definition_code = {
		--       ['<leader>ff'] = '@function.outer',
		--       ['<leader>fF'] = '@class.outer'
		--     }
		--   }
		-- }
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<Enter>",
			node_incremental = "<Enter>",
			node_decremental = "<BS>",
		},
	},
})
