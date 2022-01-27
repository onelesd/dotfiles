local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local telescope_custom_actions = {}

function telescope_custom_actions._multiaction(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local selected_entry = action_state.get_selected_entry()
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd('cfdo ' .. open_cmd)
end
function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  telescope_custom_actions._multiaction(prompt_bufnr, 'vsplit')
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
  telescope_custom_actions._multiaction(prompt_bufnr, 'split')
end
function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
  telescope_custom_actions._multiaction(prompt_bufnr, 'tabe')
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiaction(prompt_bufnr, 'edit')
end
function telescope_custom_actions.multi_selection_close(prompt_bufnr)
  telescope_custom_actions._multiaction(prompt_bufnr, 'Bdelete')
end

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {'node_modules', 'undodir'},
    layout_strategy = 'vertical',
    layout_config = {vertical = {width = 0.8, height = 0.9}},
    prompt_prefix = '🔍 ',
    vimgrep_arguments = {
      'rg', '--hidden', '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--column', '--smart-case', '--iglob', '!.git'
    },
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
        ['<C-J>'] = actions.move_selection_next,
        ['<C-K>'] = actions.move_selection_previous,
        ['<TAB>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<S-TAB>'] = actions.toggle_selection + actions.move_selection_next,
        ['<CR>'] = telescope_custom_actions.multi_selection_open,
        ['<C-v>'] = telescope_custom_actions.multi_selection_open_vsplit,
        ['<C-s>'] = telescope_custom_actions.multi_selection_open_split,
        ['<C-t>'] = telescope_custom_actions.multi_selection_open_tab,
        ['<C-x>'] = telescope_custom_actions.multi_selection_close,
        ['<S-DOWN>'] = require('telescope.actions').cycle_history_next,
        ['<S-UP>'] = require('telescope.actions').cycle_history_prev,
        ['<C-?>'] = actions.which_key
      },
      n = i
    }
  },
  extensions = {
    -- ['ui-select'] = {require('telescope.themes').get_dropdown()},
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case' -- or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('project')
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('ui-select')
-- require('telescope').load_extension('file_browser')
