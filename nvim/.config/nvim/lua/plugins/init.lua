local fn = vim.fn
local ensure_packer = function()
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.api.nvim_cmd({ cmd = "packadd packer.nvim" })

		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")
packer.init({
	git = {
		clone_timeout = 180,
	},
})
packer.startup(function(use)
	-- packer packer
	use("wbthomason/packer.nvim")

	-- git blame in virtual text toggled with <leader-gb>
	use("f-person/git-blame.nvim")

	-- nice colors
	use("rmehri01/onenord.nvim")
	use("rebelot/kanagawa.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- fancy highlighting and other cool code parsing stuff
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- for navigating visual selections in code
	use("RRethy/nvim-treesitter-textsubjects")
	-- sets the comment string for the current text. good for embdedded languages like JSX in TS
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- will add closing tags for elixir and bash and a few others. for ex, "do" will add an "end" automatically
	-- use 'windwp/nvim-ts-autotag'

	-- jump around text objects (like functions)
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- use 'nvim-treesitter/nvim-treesitter-refactor'

	-- great file explorer mapped to "-"
	-- use("jeetsukumaran/vim-filebeagle")
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
				},
			})
		end,
	})

	-- -- Using packer
	use({
		"LeonHeidelbach/trailblazer.nvim",
		config = function()
			require("trailblazer").setup({
				mappings = {
					n = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
						motions = {
							new_trail_mark = "<A-l>",
							peek_move_next_down = "<A-j>",
							peek_move_previous_up = "<A-k>",
						},
						actions = {
							delete_all_trail_marks = "<A-L>",
						},
					},
				},
			})
		end,
	})
	-- open and work with repl's in various languages
	-- use {
	--   'jpalardy/vim-slime',
	--   config = function()
	--     vim.g.slime_target = 'neovim'
	--   end
	-- }

	-- go to the last place you were in a file when re-opening it
	use({
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	})

	-- comment(ary)
	-- use({
	-- 	"terrortylor/nvim-comment",
	-- 	config = function()
	-- 		require("nvim_comment").setup({})
	-- 	end,
	-- })

	-- auto brackets
	-- use("windwp/nvim-autopairs")
	use({
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup()
		end,
	})

	-- web devicons
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				-- your personnal icons can go here (to override)
				-- DevIcon will be appended to `name`
				override = {},
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				default = true,
			})
		end,
	})

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- git signs in the gutter
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- floating terminal
	use("voldikss/vim-floaterm")
	-- use({
	-- 	"kdheepak/lazygit.nvim",
	-- 	-- optional for floating window border decoration
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- })

	-- session manager
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_suppress_dirs = { "~/" },
			})
		end,
	})
	-- use({
	-- 	"echasnovski/mini.sessions",
	-- 	config = function()
	-- 		require("mini.sessions").setup({
	-- 			autoread = true,
	-- 			autowrite = true,
	-- 			directory = fn.stdpath("data") .. "/session",
	-- 		})
	-- 	end,
	-- })

	-- add mappings for surrounding words with characters like "" and ()
	-- NOTE thisn isn't working - the maps don't do anything
	-- see: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md#default-config
	use({
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	})

	-- delete buffers without messing up layout
	use("famiu/bufdelete.nvim")

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			-- pin to this commit to prevent multiple tsserver lsp servers from attaching to the same buffer
			{ "neovim/nvim-lspconfig", commit = "3e2cc7061957292850cc386d9146f55458ae9fe3" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" }, -- typescript lsp support
			-- { "jose-elias-alvarez/null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			-- { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- dim unused references
	use({
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.35,
				blend_color = "#1f1f28",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					underline = false,
					signs = true,
				},
			})
		end,
	})

	-- TODO helper
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info" },
					-- HACK = { icon = " ", color = "warning" },
					-- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					-- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					-- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					-- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
			})
		end,
	})

	-- split and join treesitter objects
	use({
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
		config = function()
			require("treesj").setup()
		end,
	})

	-- telescope is for finding and searching files
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },
			{ "kkharji/sqlite.lua" },
			-- { "nvim-telescope/telescope-live-grep-args.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
			{ "natecraddock/telescope-zf-native.nvim" },

			{ "danielfalk/smart-open.nvim" },
			{
				"benfowler/telescope-luasnip.nvim",
				module = "telescope._extensions.luasnip",
			},
		},
	})

	-- ui sugar for lsp
	-- use 'tami5/lspsaga.nvim'
	-- use("glepnir/lspsaga.nvim")

	use({
		"nvimdev/lspsaga.nvim",
		-- pin to this commit because 0.3.0 is a full rewrite and is causing errors
		commit = "4f075452c466df263e69ae142f6659dcf9324bf6",
	})

	-- autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
	})

	use({
		"L3MON4D3/LuaSnip", -- powerful snippets
		requires = {
			"rafamadriz/friendly-snippets", -- common snippets for various languages
		},
		config = function()
			require("luasnip.loaders.from_vscode").load({
				exclude = { "javascript" },
			})
		end,
	})

	-- use SchemaStore schemas in lsp
	use("b0o/schemastore.nvim")

	-- show nice icons in completion popups and other places
	use("onsails/lspkind-nvim")

	-- make the diagnostics window pretty. also can send telescope results to it with <Ctrl-t>
	use("folke/trouble.nvim")

	-- <leader-go> opens current line in github. nice to share links.
	use({
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("gitlinker").setup({
				mappings = nil,
			})
		end,
	})

	-- sorts completions prefixed with underscore lower since they aren't normally useful
	use("lukas-reineke/cmp-under-comparator")

	-- adds indentation guides using virtual text
	-- use("lukas-reineke/indent-blankline.nvim")
	use({
		"echasnovski/mini.indentscope",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	})

	-- highlight trailing whitespace
	-- :StripWhitespace removes all extra whitespace
	-- use("ntpeters/vim-better-whitespace")

	-- provides various commands
	-- :Delete, :Move, :Rename, others...
	use("tpope/vim-eunuch")

	-- supercharge <C-x> & <C-a> to increment words, like true/false, enabled/disabled
	use("Konfekt/vim-CtrlXA")

	-- for working with csv files. wee: https://github.com/chrisbra/csv.vim
	-- use({
	-- 	"chrisbra/csv.vim",
	-- 	config = function()
	-- 		vim.cmd([[
	--       augroup filetypedetect
	--         au! BufRead,BufNewFile *.csv.gz	setfiletype csv
	--       augroup END
	--     ]])
	-- 	end,
	-- })

	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	})

	-- use({
	-- 	"ray-x/lsp_signature.nvim",
	-- 	config = function()
	-- 		require("lsp_signature").setup({})
	-- 	end,
	-- })

	-- use({ "zbirenbaum/copilot.lua" })

	-- use({ "zbirenbaum/copilot-cmp" })

	-- use({ "codota/tabnine-nvim", run = "./dl_binaries.sh" })
	-- use({
	-- 	"tzachar/cmp-ai",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- })

	-- fancy notifications
	use({
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	})

	-- gc commenting
	use({
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
		end,
	})

	-- easy movements via treesitter
	use({ "ziontee113/SelectEase" })

	-- linting
	use({ "mfussenegger/nvim-lint" })

	-- formatting
	use({ "mhartington/formatter.nvim" })

	-- for playing with treesitter - usually to discover node types for scripting
	use({ "nvim-treesitter/playground" })

	-- dash documentation app
	use({
		"mrjones2014/dash.nvim",
		run = "make install",
	})

	-- we just want the BufferCloseAllButVisible this package provides and nothing else
	-- use({
	-- 	"romgrk/barbar.nvim",
	-- 	requires = "nvim-web-devicons",
	-- 	config = function()
	-- 		require("romgrk/barbar.nvim").setup({
	-- 			animation = false,
	-- 			auto_hide = false,
	-- 			clickable = false,
	-- 		})
	-- 	end,
	-- })

	-- code navigation breadcrumbs
	-- use({
	-- 	"SmiteshP/nvim-navbuddy",
	-- 	requires = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"SmiteshP/nvim-navic",
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- })

	-- elixir support
	-- use({
	-- 	"elixir-tools/elixir-tools.nvim",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("elixir").setup()
	-- 	end,
	-- })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- leave at bottom so packages can be installed before we try working with them
-- theme
-- require("plugins/onenord")
require("plugins/kanagawa")
-- require("plugins/catppuccin")

-- other
-- require("plugins/null-ls")
require("plugins/lsp-zero")
require("plugins/lspsaga")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/lualine")
require("plugins/trouble")
require("plugins/snippets")
require("plugins/gitsigns")
require("plugins/diagnostics")
require("plugins/nvim-lint")
require("plugins/formatter")
-- require("plugins/copilot")
-- require("plugins/tabnine")
-- require("plugins/cmp-ai")
