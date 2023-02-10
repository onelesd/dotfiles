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

require("packer").startup(function(use)
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
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/nvim-lsp-installer" },
			{ "jose-elias-alvarez/nvim-lsp-ts-utils" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use("jose-elias-alvarez/null-ls.nvim")

	-- telescope is for finding and searching files
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },
			{ "natecraddock/telescope-zf-native.nvim" },
			{ "kkharji/sqlite.lua" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "danielfalk/smart-open.nvim" },
			-- { "nvim-telescope/telescope-file-browser.nvim" },
			{
				"benfowler/telescope-luasnip.nvim",
				module = "telescope._extensions.luasnip",
			},
		},
	})

	-- ui sugar for lsp
	-- use 'tami5/lspsaga.nvim'
	use("glepnir/lspsaga.nvim")

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
			require("luasnip.loaders.from_vscode").load()
		end,
	})

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
	use("ntpeters/vim-better-whitespace")

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

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({})
		end,
	})

	use({ "zbirenbaum/copilot.lua" })

	use({ "zbirenbaum/copilot-cmp" })

	-- animate common actions
	use({
		"echasnovski/mini.animate",
		config = function()
			require("mini.animate").setup()
		end,
	})

	-- gc commenting
	use({
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- leave at bottom so packages can be installed before we try working with them
-- theme
require("plugins/onenord")
-- require("plugins/kanagawa")
-- require("plugins/catppuccin")

-- other
require("plugins/null-ls")
require("plugins/lsp-zero")
require("plugins/lspsaga")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/lualine")
-- require("plugins/autopairs")
-- require("plugins/indent-blankline")
require("plugins/trouble")
require("plugins/snippets")
require("plugins/gitsigns")
require("plugins/copilot")
