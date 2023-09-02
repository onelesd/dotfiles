local Path = require("plenary.path")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local os_sep = Path.path.sep
local pickers = require("telescope.pickers")
local scan = require("plenary.scandir")

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ",\n"
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function implode(delimiter, list)
	local len = #list
	if len == 0 then
		return ""
	end
	cwd = vim.loop.cwd()
	local string = list[1]:sub(cwd:len() + 2)
	for i = 2, len do
		string = string .. delimiter .. list[i]:sub(cwd:len() + 2)
	end
	if string:len() == 0 then
		return "*"
	else
		return string
	end
end

local my_pickers = {}

my_pickers.live_grep_in_folder = function(opts)
	opts = opts or {}
	local data = {}
	scan.scan_dir(vim.loop.cwd(), {
		hidden = opts.hidden,
		only_dirs = true,
		respect_gitignore = opts.respect_gitignore,
		on_insert = function(entry)
			table.insert(data, entry .. os_sep)
		end,
	})
	table.insert(data, 1, "." .. os_sep)

	pickers
		.new(opts, {
			prompt_title = "Folders for Live Grep",
			finder = finders.new_table({
				results = data,
				entry_maker = make_entry.gen_from_file(opts),
			}),
			previewer = conf.file_previewer(opts),
			sorter = conf.file_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				action_set.select:replace(function()
					local current_picker = action_state.get_current_picker(prompt_bufnr)
					local dirs = {}
					local selections = current_picker:get_multi_selection()
					if vim.tbl_isempty(selections) then
						table.insert(dirs, action_state.get_selected_entry().value)
					else
						for _, selection in ipairs(selections) do
							table.insert(dirs, selection.value)
						end
					end
					actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
					require("telescope.builtin").live_grep({
						prompt_prefix = " Search Project [in: " .. implode(", ", dirs) .. "] > ",
						search_dirs = dirs,
					})
				end)
				return true
			end,
		})
		:find()
end
local borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
local opts = {
	debounce = 100,
	width = 0.8,
	show_line = false,
	prompt_title = "",
	results_title = "",
	preview_title = "",
	file_ignore_patterns = { "node_modules", "undodir" },
	layout_strategy = "vertical",
	layout_config = {
		vertical = { width = 0.5, height = 0.9, preview_height = 0.75 },
		horizontal = { width = 0.8, height = 0.9, preview_width = 0.5 },
	},
	borderchars = {
		borderchars,
		prompt = borderchars,
		results = borderchars,
		preview = borderchars,
	},
	vimgrep_arguments = {
		"rg",
		"--hidden",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
		"--trim",
		"--glob",
		"!{.git,**/.aws-sam/**,**/dist/**,**/*.gltf}",
	},
}

local enhance_opts = {
	["find_files"] = function(opts)
		-- opts.find_command = {'rg', '--files', '--iglob', '!.git', '--hidden'} -- for telescope built-in
		opts.cwd_only = true -- for smart_open telescope extension
		opts.prompt_prefix = "Project> "
		return opts
	end,
	["live_grep"] = function(opts)
		opts.prompt_prefix = "Search Project> "
		return opts
	end,
	["live_grep_in_folder"] = function(opts)
		opts.prompt_prefix = "Search Project Folders> "
		return opts
	end,
	["current_buffer_fuzzy_find"] = function(opts)
		opts.prompt_prefix = "Search File> "
		return opts
	end,
	["buffers"] = function(opts)
		opts.prompt_prefix = "Buffers> "
		return opts
	end,
	["help_tags"] = function(opts)
		opts.prompt_prefix = "Help> "
		return opts
	end,
	["project"] = function(opts)
		opts.prompt_prefix = "Projects> "
		return opts
	end,
	["recent"] = function(opts)
		opts.prompt_prefix = "Recent> "
		return opts
	end,
}

return {
	borderchars = borderchars,
	telescope_find_files = function()
		-- require("telescope.builtin").find_files(enhance_opts["find_files"](opts))
		require("telescope").extensions.smart_open.smart_open(enhance_opts["find_files"](opts))
	end,
	telescope_live_grep = function(default_text)
		opts.default_text = default_text or ""
		require("telescope.builtin").live_grep(enhance_opts["live_grep"](opts))
	end,
	telescope_live_grep_in_folder = function(default_text)
		opts.default_text = default_text or ""
		my_pickers.live_grep_in_folder(enhance_opts["live_grep_in_folder"](opts))
	end,
	telescope_current_buffer_fuzzy_find = function(default_text)
		opts.default_text = default_text or ""
		require("telescope.builtin").current_buffer_fuzzy_find(enhance_opts["current_buffer_fuzzy_find"](opts))
	end,
	telescope_buffers = function()
		require("telescope.builtin").buffers(enhance_opts["buffers"](opts))
	end,
	telescope_help_tags = function()
		require("telescope.builtin").help_tags(enhance_opts["help_tags"](opts))
	end,
	telescope_project = function()
		require("telescope").extensions.project.project(enhance_opts["project"](opts))
	end,
	telescope_recent = function()
		require("telescope").extensions.frecency.frecency(enhance_opts["recent"](opts))
		-- require('telescope.builtin').oldfiles()
	end,
	mix_latest = function()
		local package = vim.fn.input("Package name: ")
		vim.cmd("r! mix-latest " .. package)
		vim.cmd('call feedkeys("==")')
	end,
	saveas = function()
		local current_file = vim.fn.expand("%:t")
		local filename = vim.fn.input("New filename: ", current_file)
		local filedir = vim.fn.expand("%:h")
		vim.cmd("saveas " .. filedir .. "/" .. filename)
	end,
	mix_test_line = function()
		local linenum = vim.api.nvim_win_get_cursor(0)[1]
		vim.cmd("hi FloatermBorder guifg=transparent")
		vim.cmd(
			"FloatermNew --width=0.9 --height=0.9 --borderchars="
				.. borderchars
				.. " --autoclose=0 mix test %:"
				.. linenum
		)
	end,
}
