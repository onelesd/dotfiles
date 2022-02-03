require'nvim-treesitter.configs'.setup {
  -- "all", "maintained", or a list of languages
  ensure_installed = 'maintained',

  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    disable = {'lua'},

    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },

    additional_vim_regex_highlighting = false
  },

  indent = {enable = true},

  matchup = {
    enable = false, -- mandatory, false will disable the whole extension
    disable = {} -- optional, list of language that will be disabled
    -- [options]
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?'
    }
  },

  refactor = {
    highlight_definitions = {enable = true},
    highlight_current_scope = {enable = false},
    smart_rename = {enable = true, keymaps = {smart_rename = 'grr'}}
    -- navigation = {
    --   enable = true,
    --   keymaps = {
    --     goto_definition = "gnd",
    --     list_definitions = "gnD",
    --     list_definitions_toc = "gO",
    --     goto_next_usage = "<a-*>",
    --     goto_previous_usage = "<a-#>",
    --   },
    -- },
    -- textobjects = {
    --   lsp_interop = {
    --     enable = true,
    --     border = 'none',
    --     peek_definition_code = {
    --       ['<leader>ff'] = '@function.outer',
    --       ['<leader>fF'] = '@class.outer'
    --     }
    --   }
    -- }
  }

  -- not sure what this does
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
}
