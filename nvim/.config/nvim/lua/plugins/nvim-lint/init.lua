require("lint").linters_by_ft = {
	-- typescript = { "eslint_d" }, -- we use the eslint lsp server now instead
	-- typescriptreact = { "eslint_d" }, -- we use the eslint lsp server now instead
	lua = { "luacheck" },
	yaml = { "actionlint" }, -- cfn_lint is enabled through cfn-lsp-extra. yamllint is too noisy
	json = { "jsonlint" },
	terraform = { "tfsec" },
}

-- customize linters
local luacheck = require("lint").linters.luacheck
luacheck.args = {
	"--formatter",
	"plain",
	"--codes",
	"--ranges",
	"--read-globals",
	"vim",
	"-",
}

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "TextChanged" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

-- allow eslint to lint the buffer without having to write first
-- note that eslint_d is already configured this way by nvim-lint
-- local eslint = require("lint").linters.eslint
-- eslint.args = {
-- 	"--stdin",
-- 	"--stdin-filename",
-- 	function()
-- 		return vim.api.nvim_buf_get_name(0)
-- 	end,
-- }
-- eslint.stdin = true

-- we use the eslint lsp server now instead
-- local severity_map = {
-- 	[1] = vim.diagnostic.severity.WARN,
-- 	[2] = vim.diagnostic.severity.ERROR,
-- }
-- local eslint_d = require("lint").linters.eslint_d
-- eslint_d.args = {
-- 	"--cache",
-- 	"--cache-location",
-- 	".eslintcache",
-- 	"--format",
-- 	"json",
-- 	"--stdin",
-- 	"--stdin-filename",
-- 	function()
-- 		return vim.api.nvim_buf_get_name(0)
-- 	end,
-- }
-- eslint_d.parser = function(output)
-- 	if output == nil then
-- 		return {}
-- 	end
--
-- 	local messages = vim.json.decode(output)
-- 	local diagnostics = {}
--
-- 	for _, outer_message in ipairs(messages or {}) do
-- 		for _, message in ipairs(outer_message.messages) do
-- 			table.insert(diagnostics, {
-- 				lnum = message.line - 1,
-- 				end_lnum = message.endLine - 1,
-- 				col = message.column - 1,
-- 				end_col = message.endColumn - 1,
-- 				message = message.message,
-- 				source = "eslint_d",
-- 				severity = severity_map[message.severity] or vim.diagnostic.severity.ERROR,
-- 				code = message.ruleId,
-- 				user_data = {
-- 					lsp = {
-- 						code = message.ruleId,
-- 					},
-- 				},
-- 			})
-- 		end
-- 	end
--
-- 	return diagnostics
-- end
