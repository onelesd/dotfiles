local actions = require("telescope.actions")
vim.cmd("highlight TelescopeBorder guifg=#24283b")
local trouble = require("trouble.providers.telescope")
local lga_actions = require("telescope-live-grep-args.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
        ["<C-J>"] = actions.move_selection_next,
        ["<C-K>"] = actions.move_selection_previous,
        ["<C-t>"] = trouble.smart_open_with_trouble,
        ["<S-DOWN>"] = require("telescope.actions").cycle_history_next,
        ["<S-UP>"] = require("telescope.actions").cycle_history_prev,
        ["<C-?>"] = actions.which_key,
      },
      n = {
        ["<ESC>"] = actions.close,
        ["<C-J>"] = actions.move_selection_next,
        ["<C-K>"] = actions.move_selection_previous,
        ["<C-t>"] = trouble.smart_open_with_trouble,
        ["<S-DOWN>"] = require("telescope.actions").cycle_history_next,
        ["<S-UP>"] = require("telescope.actions").cycle_history_prev,
        ["<C-?>"] = actions.which_key,
      },
    },
  },
  extensions = {
    -- ['dash'] = {
    -- },
    ["zf-native"] = {
      -- options for sorting file-like items
      file = {
        -- override default telescope file sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- enable zf filename match priority
        match_filename = true,
      },

      -- options for sorting all other items
      generic = {
        -- override default telescope generic item sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- disable zf filename match priority
        match_filename = false,
      },
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-l>"] = lga_actions.quote_prompt({ postfix = " --glob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
  },
})
require("telescope").load_extension("project")
require("telescope").load_extension("zf-native")
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("smart_open")
-- require('telescope').load_extension('file_browser')
