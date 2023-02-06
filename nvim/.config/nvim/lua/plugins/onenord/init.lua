-- see this for enabling undercurl in iterm: https://gitlab.com/gnachman/iterm2/-/issues/6382
require("onenord").setup({
	styles = {
		comments = "italic", -- Style that is applied to comments: see `highlight-args` for options
	},
	custom_highlights = {
		-- this isn't working. styles.diagnostics above works but this should too...
		LspDiagnosticsUnderlineError = { style = "undercurl" },
	},
})
