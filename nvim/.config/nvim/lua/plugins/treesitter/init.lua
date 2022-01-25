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
