require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- theme = "onenord",
		-- component_separators = {left = '', right = ''},
		-- section_separators = {left = '', right = ''},
		component_separators = { left = "|", right = "|" },
		section_separators = { left = " ", right = " " },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {},
		-- lualine_b = {'branch', 'diff', {'diagnostics', sources = {'nvim_lsp'}}},
		lualine_b = {
			"branch",
			"diff",
		},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
		},
		lualine_y = { "filetype" },
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
	extensions = { "quickfix" },
})
