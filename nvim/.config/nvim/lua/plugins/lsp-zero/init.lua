local cmp = require("cmp")
local lsp = require("lsp-zero")
local lspkind = require("lspkind")

-- this feels like the wrong place to put this, but also the best
-- to get syntax highlighting for terraform files
vim.cmd([[
  autocmd BufNewFile,BufRead *.tf set syntax=tf
]])

-- to set some json files to jsonc so comments aren't errors
vim.cmd([[
  autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  autocmd BufNewFile,BufRead rush.json setlocal filetype=jsonc
]])

lsp.preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = true,
})

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

lsp.setup_nvim_cmp({
	sources = {
		{ name = "copilot" },
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = lsp.defaults.cmp_mappings({
		["<CR>"] = cmp.mapping.confirm({
			-- documentation says this is important.
			-- I don't know why.
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			max_width = 50,
			symbol_map = { Copilot = "" },
		}),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			require("copilot_cmp.comparators").prioritize,
			require("copilot_cmp.comparators").score,

			-- Below is the default comparitor list and order for nvim-cmp
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

-- add support for lua neovim config
lsp.nvim_workspace()

-- lsp.ensure_installed({
-- 	"bashls",
-- 	"cssmodules_ls",
-- 	"elixirls",
-- 	"jsonls",
-- 	"sumneko_lua",
-- 	"svelte",
-- 	"tailwindcss",
-- 	"tsserver",
-- 	"yamlls",
-- })

-- disable formatters because we'll use null-ls
local on_attach_fn = function(client)
	--do default stuff for all lsp servers here
end

local lsp_configure = function(client, opts)
	if opts.on_attach ~= nil then
		opts.on_attach = function()
			on_attach_fn(client)
		end
	end
	lsp.configure(client, opts)
end

lsp_configure("cssmodules_ls", {
	filetypes = {
		"javascript",
		"typescript",
		"css",
	},
})

lsp_configure("yamlls", {
	settings = {
		yaml = {
			customTags = {
				-- these are for sam templates
				"!Equals sequence",
				"!FindInMap sequence",
				"!GetAtt scalar",
				"!GetAZs scalar",
				"!ImportValue scalar",
				"!Join sequence scalar",
				"!Ref scalar",
				"!Select sequence",
				"!Split sequence",
				"!Sub scalar",
				"!And sequence",
				"!Not sequence",
				"!Equals sequence",
				"!Sub sequence",
				"!ImportValue scalar",
				"!If sequence",
			},
		},
	},
})

lsp_configure("elixirls", {
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
			fetchDeps = false,
		},
	},
})

lsp_configure("sumneko_lua", {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = {
					"vim",
					"hs", -- hammerspoon
					"spoon", -- hammerspoon
				},
				disable = {
					"lowercase-global",
				},
			},
		},
	},
})

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		debug = false,
		-- disable_commands = false,
		enable_import_on_completion = true,

		-- import all
		import_all_timeout = 5000, -- ms
		-- lower numbers = higher priority
		import_all_priorities = {
			same_file = 1, -- add to existing import statement
			local_files = 2, -- git files or files with relative path markers
			buffer_content = 3, -- loaded buffer content
			buffers = 4, -- loaded buffer names
		},
		import_all_scan_buffers = 100,
		import_all_select_source = false,
		-- if false will avoid organizing imports
		always_organize_imports = true,

		-- filter diagnostics
		filter_out_diagnostics_by_severity = {},
		filter_out_diagnostics_by_code = {
			-- filter this message as it is basically never useful
			-- File is a CommonJS module; it may be converted to an ES module. typescript (80001)
			80001,
		},

		-- inlay hints
		auto_inlay_hints = true,
		inlay_hints_highlight = "Comment",
		inlay_hints_priority = 200, -- priority of the hint extmarks
		inlay_hints_throttle = 150, -- throttle the inlay hint request
		inlay_hints_format = { -- format options for individual hint kind
			Type = {},
			Parameter = {},
			Enum = {},
		},

		-- update imports on file move
		update_imports_on_move = true,
		require_confirmation_on_move = false,
		watch_dir = nil,
	},
})

lsp.setup()
