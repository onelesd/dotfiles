local cmp_ai = require("cmp_ai.config")

cmp_ai:setup({
	max_lines = 1000,
	provider = "Bard",
	notify = false,
	run_on_every_keystroke = true,
	ignored_file_types = {
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
})
