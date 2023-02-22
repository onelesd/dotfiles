require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup({
	method = "getCompletionsCycling",
	formatters = {
		label = require("copilot_cmp.format").format_label_text,
		preview = require("copilot_cmp.format").deindent,
		insert_text = require("copilot_cmp.format").format_insert_text,
		-- this insert_text from https://github.com/zbirenbaum/copilot-cmp#formatters
		-- The label field corresponds to the function returning the label of the entry in nvim-cmp, insert_text corresponds to the actual text that is inserted, and preview corresponds to the text shown in the documentation window when hovering the completion.
		-- There is an experimental method for attempting to remove extraneous characters such as extra ending parenthesis that appears to work fairly well.
		-- insert_text = require("copilot_cmp.format").remove_existing,
	},
})