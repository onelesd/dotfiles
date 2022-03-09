local actions = require 'telescope.actions'
vim.cmd 'highlight TelescopeBorder guifg=#24283b'
local trouble = require('trouble.providers.telescope')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
        ['<C-J>'] = actions.move_selection_next,
        ['<C-K>'] = actions.move_selection_previous,
        ['<C-t>'] = trouble.smart_open_with_trouble,
        ['<S-DOWN>'] = require('telescope.actions').cycle_history_next,
        ['<S-UP>'] = require('telescope.actions').cycle_history_prev,
        ['<C-?>'] = actions.which_key
      },
      n = i
    }
  },
  extensions = {
    -- ['dash'] = {
    -- },
    ['zf-native'] = {
      -- options for sorting file-like items
      file = {
        -- override default telescope file sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- enable zf filename match priority
        match_filename = true
      },

      -- options for sorting all other items
      generic = {
        -- override default telescope generic item sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- disable zf filename match priority
        match_filename = false
      }
    }
  }
}
require('telescope').load_extension('project')
require('telescope').load_extension('zf-native')
