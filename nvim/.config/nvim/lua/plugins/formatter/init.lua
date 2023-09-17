vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*",
	command = "FormatWrite",
})

-- Utilities for creating configurations
local util = require("formatter.util")

local util = require("formatter.util")

function local_eslint_d()
	return {
		exe = "eslint_d",
		args = {
			"--stdin",
			"--stdin-filename",
			util.escape_path(util.get_current_buffer_file_path()),
			"--fix-to-stdout",
		},
		stdin = true,
		try_node_modules = true,
	}
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order

		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},

		json = {
			require("formatter.filetypes.json").prettier,
		},

		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			-- function()
			--   -- Supports conditional formatting
			--   -- if util.get_current_buffer_file_name() == "special.lua" then
			--   --   return nil
			--   -- end
			--
			--   -- Full specification of configurations is down below and in Vim help
			--   -- files
			--   return {
			--     exe = "stylua",
			--     args = {
			--       "--search-parent-directories",
			--       "--stdin-filepath",
			--       util.escape_path(util.get_current_buffer_file_path()),
			--       "--",
			--       "-",
			--     },
			--     stdin = true,
			--   }
			-- end
		},

		markdown = {
			require("formatter.filetypes.markdown").prettierd,
		},

		terraform = {
			require("formatter.filetypes.terraform").prettierd,
		},

		toml = {
			require("formatter.filetypes.toml").taplo,
		},

		typescript = {
			require("formatter.filetypes.typescript").prettierd,
			-- require("formatter.filetypes.typescript").eslint_d,
		},

		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettierd,
			-- require("formatter.filetypes.typescriptreact").eslint_d,
		},

		elixir = {
			require("formatter.filetypes.elixir").mixformat,
		},

		yaml = {
			require("formatter.filetypes.yaml").prettierd,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
