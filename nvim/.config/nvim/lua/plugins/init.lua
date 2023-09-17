-- local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lazy requires leader to be mapped before it runs
-- what is this, spacemacs?
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({

	-- git blame in virtual text toggled with <leader-gb>
	{
		"f-person/git-blame.nvim",
		cmd = "GitBlameToggle",
	},

	-- nice colors
	"rebelot/kanagawa.nvim",

	-- fancy highlighting and other cool code parsing stuff
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	-- for navigating visual selections in code
	-- "RRethy/nvim-treesitter-textsubjects",
	-- sets the comment string for the current text. good for embdedded languages like JSX in TS
	-- "JoosepAlviste/nvim-ts-context-commentstring",

	-- jump around text objects (like functions)
	-- "nvim-treesitter/nvim-treesitter-textobjects",

	-- great file explorer mapped to "-"
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
				},
			})
		end,
	},

	-- go to the last place you were in a file when re-opening it
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},

	-- auto brackets
	{
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup()
		end,
	},

	-- status line
	"nvim-lualine/lualine.nvim",

	-- git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- floating terminal
	{ "voldikss/vim-floaterm", cmd = { "FloatermKill" } },

	-- session manager
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_suppress_dirs = { "~/" },
			})
		end,
	},

	-- add mappings for wrapping words with characters like "" and ()
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	},

	-- delete buffers without messing up layout
	"famiu/bufdelete.nvim",

	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			-- pin to this commit to prevent multiple tsserver lsp servers from attaching to the same buffer
			{
				"neovim/nvim-lspconfig",
				-- commit = "3e2cc7061957292850cc386d9146f55458ae9fe3",
			},
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" }, -- typescript lsp support

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		event = "LspAttach",
	},

	-- dim unused references
	{
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
	},

	-- code notes helper for todos and notes
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
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
	},

	-- split and join treesitter objects
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("treesj").setup()
		end,
	},

	-- telescope is for finding and searching files
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-project.nvim",
			"kkharji/sqlite.lua",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"natecraddock/telescope-zf-native.nvim",

			"danielfalk/smart-open.nvim",
			{
				"benfowler/telescope-luasnip.nvim",
				module = "telescope._extensions.luasnip",
			},
		},
	},

	-- ui sugar for lsp
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		-- pin to this commit because 0.3.0 is a full rewrite and is causing errors
		-- commit = "4f075452c466df263e69ae142f6659dcf9324bf6",
	},

	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	{
		"L3MON4D3/LuaSnip", -- powerful snippets
		dependencies = {
			"rafamadriz/friendly-snippets", -- common snippets for various languages
		},
		config = function()
			require("luasnip.loaders.from_vscode").load({
				exclude = { "javascript" },
			})
		end,
	},

	-- use SchemaStore schemas in lsp
	"b0o/schemastore.nvim",

	-- show nice icons in completion popups and other places
	"onsails/lspkind-nvim",

	-- make the diagnostics window pretty. also can send telescope results to it with <Ctrl-t>
	"folke/trouble.nvim",

	-- <leader-go> opens current line in github. nice to share links.
	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitlinker").setup({
				mappings = nil,
			})
		end,
	},

	-- sorts completions prefixed with underscore lower since they aren't normally useful
	"lukas-reineke/cmp-under-comparator",

	-- adds indentation guides using virtual text
	{
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
	},

	-- provides various commands
	-- :Delete, :Move, :Rename, others...
	"tpope/vim-eunuch",

	-- supercharge <C-x> & <C-a> to increment words, like true/false, enabled/disabled
	"Konfekt/vim-CtrlXA",

	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	},

	-- fancy notifications
	{ "folke/noice.nvim", dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	} },

	-- gc commenting
	{
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- easy movements via treesitter
	"ziontee113/SelectEase",

	-- linting
	"mfussenegger/nvim-lint",

	-- formatting
	"stevearc/conform.nvim",

	-- dash documentation app
	{
		"mrjones2014/dash.nvim",
		build = "make install",
	},
})

-- leave at bottom so packages can be installed before we try working with them
require("plugins/kanagawa")
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
require("plugins/conform")
require("plugins/noice")
