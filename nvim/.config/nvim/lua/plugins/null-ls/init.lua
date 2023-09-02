local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

-- tell eslint_d to ignore certain errors
local eslint_d_ignore = {
	-- when a file is ignored by .eslintrc but null-ls evaluates it this warning is shown and we don't care about it:
	-- File ignored because of a matching ignore pattern. Use "--no-ignore" to override.() eslint_d [1, 1]
	-- this happens because the eslintrc tells it to ignore test files, but null-ls passes the test file as an argument to eslint
	"File ignored because of a matching ignore pattern",
}

null_ls.setup({
	sources = {
		require("typescript.extensions.null-ls.code-actions"),
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
			filter = function(diagnostic)
				for _, message in ipairs(eslint_d_ignore) do
					if diagnostic.message ~= message then
						return nil
					end
				end

				return true
			end,
		}),
		null_ls.builtins.diagnostics.actionlint.with({ -- github actions
			diagnostics_format = "[actionlint] #{m}\n(#{c})",
		}),
		-- null_ls.builtins.diagnostics.cfn_lint.with({ -- cloud formation
		-- 	diagnostics_format = "[cfnlint] #{m}\n(#{c})",
		-- }),
		null_ls.builtins.diagnostics.luacheck.with({
			extra_args = {
				"--read-globals",
				"vim",
			},
			diagnostics_format = "[luacheck] #{m}\n(#{c})",
		}),
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.diagnostics.credo,
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = 0,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
