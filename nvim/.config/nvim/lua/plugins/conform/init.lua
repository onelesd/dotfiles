require("conform").setup({
	formatters_by_ft = {
		["*"] = { "trim_whitespace" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		-- javascript = { { "prettierd", "prettier" } },
		lua = { "stylua" },
		javascript = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		markdown = { "prettierd" },
		terraform = { "prettierd" },
		toml = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		elixir = { "mix" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1500,
		lsp_fallback = true,
	},
})
