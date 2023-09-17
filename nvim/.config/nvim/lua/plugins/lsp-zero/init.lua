local cmp = require("cmp")
local lsp = require("lsp-zero")
local lspkind = require("lspkind")
local lspconfig = require("lspconfig")
local compare = require("cmp.config.compare")

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
	manage_nvim_cmp = false,
	suggest_lsp_servers = true,
})

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- lsp.setup_nvim_cmp({
-- 	sources = {
-- 		{ name = "copilot" }, -- no keyword_length option
-- 		{ name = "path" }, -- no keyword_length option
-- 		{ name = "nvim_lsp_signature_help" },
-- 		{ name = "nvim_lsp", keyword_length = 1 }, -- 3
-- 		{ name = "buffer", keyword_length = 1 }, -- 3
-- 		{ name = "luasnip", keyword_length = 1 }, -- 2
-- 	},
-- 	mapping = lsp.defaults.cmp_mappings({
-- 		["<CR>"] = cmp.mapping.confirm({
-- 			-- behavior = cmp.ConfirmBehavior.Replace, -- documentation says this is important
-- 			select = false,
-- 		}),
-- 		["<Tab>"] = vim.schedule_wrap(function(fallback)
-- 			if cmp.visible() and has_words_before() then
-- 				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
-- 			else
-- 				fallback()
-- 			end
-- 		end),
-- 	}),
-- 	formatting = {
-- 		format = lspkind.cmp_format({
-- 			mode = "symbol",
-- 			max_width = 50,
-- 			symbol_map = { Copilot = "" },
-- 		}),
-- 	},
-- 	sorting = {
-- 		priority_weight = 2,
-- 		comparators = {
-- 			require("copilot_cmp.comparators").prioritize,
--
-- 			-- Below is the default comparitor list and order for nvim-cmp
-- 			cmp.config.compare.offset,
-- 			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
-- 			cmp.config.compare.exact,
-- 			cmp.config.compare.score,
-- 			cmp.config.compare.recently_used,
-- 			cmp.config.compare.locality,
-- 			cmp.config.compare.kind,
-- 			cmp.config.compare.sort_text,
-- 			cmp.config.compare.length,
-- 			cmp.config.compare.order,
-- 		},
-- 	},
-- })

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
local on_attach_fn = function(client, bufnr)
	--do default stuff for all lsp servers here
end

local lsp_configure = function(client, opts)
	if opts.on_attach ~= nil then
		opts.on_attach = function(client, bufnr)
			on_attach_fn(client, bufnr)
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

lsp_configure("graphql", {
	filetypes = {
		"graphql",
		"typescriptreact",
		"javascriptreact",
		"javascript",
		"typescript",
	},
	root_dir = lspconfig.util.root_pattern(".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
})

-- lsp_configure("yamlls", {
-- 	settings = {
-- 		yaml = {
-- 			customTags = {
-- 				-- these are for sam templates
-- 				"!Equals sequence",
-- 				"!FindInMap sequence",
-- 				"!GetAtt scalar",
-- 				"!GetAZs scalar",
-- 				"!ImportValue scalar",
-- 				"!Join sequence scalar",
-- 				"!Ref scalar",
-- 				"!Select sequence",
-- 				"!Split sequence",
-- 				"!Sub scalar",
-- 				"!And sequence",
-- 				"!Not sequence",
-- 				"!Equals sequence",
-- 				"!Sub sequence",
-- 				"!ImportValue scalar",
-- 				"!If sequence",
-- 			},
-- 			-- disabling this and requiring below enables the schemastore plugin
-- 			schemaStore = {
-- 				enable = false,
-- 			},
-- 			schemas = require("schemastore").yaml.schemas(),
-- 		},
-- 	},
-- })

lsp_configure("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lsp_configure("elixirls", {
	settings = {
		dialyzerEnabled = true,
		fetchDeps = false,
		enableTestLenses = false,
		suggestSpecs = false,
	},
	filetypes = {
		"elixir",
		"eelixir",
		"heex",
		"surface",
	},
})

lsp_configure("eslint", {
	settings = {
		codeActionOnSave = {
			enable = true,
			mode = "all",
		},
	},
})

lsp_configure("lua_ls", {
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

-- can override the built-in lsp handlers like this if you need to
-- see: https://github.com/jose-elias-alvarez/typescript.nvim/issues/63
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
--     local client = lsp.get_client_by_id(ctx.client_id)
--     if not (client and client.name == "tsserver") then
--         return lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, config)
--     end
--
--     for _, diagnostic in ipairs(result.diagnostics) do
--         -- do whatever you want
--     end
--
--     return lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, config)
-- end

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
			80001, -- File is a CommonJS module; it may be converted to an ES module. typescript (80001)
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

-- lsp_configure("cfn-lsp-extra", {
-- 	settings = {
-- 		json = {
-- 			schemas = require("schemastore").json.schemas(),
-- 			validate = { enable = true },
-- 		},
-- 	},
-- 	filetypes = {
-- 		"yaml",
-- 	},
-- })

lsp.setup()

-- require("lspconfig.configs").cfn_lsp_extra = {
-- 	default_config = {
-- 		name = "cfn-lsp-extra",
-- 		cmd = { "cfn-lsp-extra" },
-- 		filetypes = { "yaml" },
-- 		root_dir = lspconfig.util.find_git_ancestor,
-- 	},
-- }
--
-- require("lspconfig").cfn_lsp_extra.setup({})

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
	luasnip = "[Snip]",
}
local cmp_config = lsp.defaults.cmp_config({
	allow_duplicates = false,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered({ col_offset = 3 }),
	},
	sources = {
		{ name = "luasnip", keyword_length = 2 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{
			name = "buffer",
			keyword_length = 5,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
		{ name = "path" },
	},
	mapping = lsp.defaults.cmp_mappings({
		["<CR>"] = cmp.mapping.confirm({
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
		format = function(entry, vim_item)
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

			vim_item.menu = (source_mapping)[entry.source.name]

			vim_item.dup = ({
				luasnip = 0,
			})[entry.source.name] or 0

			return vim_item
		end,
	},
	sorting = {
		comparators = {
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			require("cmp-under-comparator").under,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
})

cmp.setup(cmp_config)
