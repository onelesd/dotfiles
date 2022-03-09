local borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'}
local opts = {
  debounce = 100,
  width = 0.8,
  show_line = false,
  prompt_title = '',
  results_title = '',
  preview_title = '',
  file_ignore_patterns = {'node_modules', 'undodir'},
  layout_strategy = 'horizontal',
  layout_config = {
    vertical = {width = 0.8, height = 0.9},
    horizontal = {width = 0.8, height = 0.9}
  },
  borderchars = {
    borderchars,
    prompt = borderchars,
    results = borderchars,
    preview = borderchars
  },
  vimgrep_arguments = {
    'rg', '--hidden', '--color=never', '--no-heading', '--with-filename',
    '--line-number', '--column', '--smart-case', '--iglob', '!.git'
  }
}

local enhance_opts = {
  ['find_files'] = function(opts)
    opts.find_command = {'rg', '--files', '--iglob', '!.git', '--hidden'}
    opts.prompt_prefix = 'Project> '
    return opts
  end,
  ['live_grep'] = function(opts)
    opts.prompt_prefix = 'Search Project> '
    return opts
  end,
  ['current_buffer_fuzzy_find'] = function(opts)
    opts.prompt_prefix = 'Search File> '
    return opts
  end,
  ['buffers'] = function(opts)
    opts.prompt_prefix = 'Buffers> '
    return opts
  end,
  ['help_tags'] = function(opts)
    opts.prompt_prefix = 'Help> '
    return opts
  end,
  ['project'] = function(opts)
    opts.prompt_prefix = 'Projects> '
    return opts
  end
}

return {
  borderchars = borderchars,
  telescope_find_files = function()
    require('telescope.builtin').find_files(enhance_opts['find_files'](opts))
  end,
  telescope_live_grep = function(default_text)
    opts.default_text = default_text or ''
    require('telescope.builtin').live_grep(enhance_opts['live_grep'](opts))
  end,
  telescope_current_buffer_fuzzy_find = function(default_text)
    opts.default_text = default_text or ''
    require('telescope.builtin').current_buffer_fuzzy_find(
        enhance_opts['current_buffer_fuzzy_find'](opts))
  end,
  telescope_buffers = function()
    require('telescope.builtin').buffers(enhance_opts['buffers'](opts))
  end,
  telescope_help_tags = function()
    require('telescope.builtin').help_tags(enhance_opts['help_tags'](opts))
  end,
  telescope_project = function()
    require('telescope').extensions.project.project(
        enhance_opts['project'](opts))
  end,
  mix_latest = function()
    local package = vim.fn.input('Package name: ')
    vim.cmd('r! mix-latest ' .. package)
    vim.cmd('call feedkeys("==")')
  end,
  saveas = function()
    local current_file = vim.fn.expand('%:t')
    local filename = vim.fn.input('New filename: ', current_file)
    local filedir = vim.fn.expand('%:h')
    vim.cmd('saveas ' .. filedir .. '/' .. filename)
  end,
  mix_test_line = function()
    local linenum = vim.api.nvim_win_get_cursor(0)[1]
    vim.cmd('hi FloatermBorder guifg=transparent')
    vim.cmd('FloatermNew --width=0.9 --height=0.9 --borderchars=' .. borderchars
                .. ' --autoclose=0 mix test %:' .. linenum)
  end
}

