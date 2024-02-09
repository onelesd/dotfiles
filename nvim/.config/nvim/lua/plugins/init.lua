-- local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy requires leader to be mapped before it runs
-- what is this, spacemacs?
vim.g.mapleader = " "
vim.g.maplocalleader = " "

function lsp_on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

require("lazy").setup({

  -- git blame in virtual text toggled with <leader-gb>
  {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
  },

  -- nice colors
  "rebelot/kanagawa.nvim",

  -- fancy highlighting and other cool code parsing stuff
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  -- great file explorer mapped to "-"
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        skip_confirm_for_simple_edits = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      })
    end,
  },

  -- go to the last place you were in a file when re-opening it
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({})
    end,
  },

  -- auto brackets
  {
    "echasnovski/mini.pairs",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- status line
  "nvim-lualine/lualine.nvim",

  -- git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- floating terminal
  { "voldikss/vim-floaterm", cmd = { "FloatermKill" } },

  -- session manager
  {
    "echasnovski/mini.sessions",
    version = "*",
    config = function()
      require("mini.sessions").setup({
        autoread = true,
        autowrite = true,
      })
    end,
  },

  -- add mappings for wrapping words with characters like "" and ()
  {
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- delete buffers without messing up layout
  "famiu/bufdelete.nvim",

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local api = require("typescript-tools.api")
      require("typescript-tools").setup({
        handlers = {
          ["textDocument/publishDiagnostics"] = api.filter_diagnostics({
            80001,
            6192,
            6133,
            6196,
          }),
        },
        expose_as_code_action = { "all" },
        complete_function_calls = true,
      })
    end,
  },

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = {
          enable = true,
          init_options = {
            experimental = {
              completions = { enable = true },
            },
          },
        },
        credo = { enable = false },
        elixirls = {
          enable = false,
          settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = false,
            fetchDeps = false,
            suggestSpecs = false,
          }),
          on_attach = function(client, bufnr)
            vim.keymap.set(
              "n",
              "<space>fp",
              ":ElixirFromPipe<cr>",
              { buffer = true, noremap = true }
            )
            vim.keymap.set(
              "n",
              "<space>tp",
              ":ElixirToPipe<cr>",
              { buffer = true, noremap = true }
            )
            vim.keymap.set(
              "v",
              "<space>em",
              ":ElixirExpandMacro<cr>",
              { buffer = true, noremap = true }
            )
          end,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    config = function()
      require("output_panel").setup()
    end,
  },

  { "emmanueltouzery/elixir-extras.nvim" },

  { "neovim/nvim-lspconfig" },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      -- local cmp_action = lsp_zero.cmp_action()

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
              :match("^%s*$")
            == nil
      end

      cmp.setup({
        sources = {
          { name = "luasnip", keyword_length = 2 },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp", keyword_length = 3 },
          {
            name = "buffer",
            keyword_length = 4,
            option = {
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          { name = "path" },
        },
        allow_duplicates = false,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered({ col_offset = 3 }),
        },
        formatting = lsp_zero.cmp_format(),
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = lsp_zero.defaults.cmp_mappings({
          ["<CR>"] = cmp.mapping.confirm({
            select = false,
          }),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        }),
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require("mason-lspconfig").setup({
        ensure_installed = { "svelte", "lua_ls" },
        automatic_installation = true,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          -- elixirls = function()
          --   require("lspconfig").elixirls.setup({
          --     settings = {
          --       elixirLS = {
          --         dialyzerEnabled = true,
          --         enableTestLenses = false,
          --         fetchDeps = false,
          --         suggestSpecs = false,
          --         mixEnv = "dev",
          --       },
          --     },
          --   })
          -- end,
          svelte = function()
            require("lspconfig").svelte.setup({
              settings = {
                svelte = {
                  plugin = {
                    svelte = {
                      compilerWarnings = {
                        ["unused-export-let"] = "ignore",
                      },
                    },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  -- code notes helper for todos and notes
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          -- HACK = { icon = " ", color = "warning" },
          -- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          -- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          -- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })
    end,
  },

  -- split and join treesitter objects
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("treesj").setup()
    end,
  },

  -- telescope is for finding and searching files
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      "kkharji/sqlite.lua",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "natecraddock/telescope-zf-native.nvim",

      "danielfalk/smart-open.nvim",
      {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip",
      },
    },
  },

  -- ui sugar for lsp
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- use SchemaStore schemas in lsp
  "b0o/schemastore.nvim",

  -- show nice icons in completion popups and other places
  "onsails/lspkind-nvim",

  -- make the diagnostics window pretty. also can send telescope results to it with <Ctrl-t>
  "folke/trouble.nvim",

  -- <leader-go> opens current line in github. nice to share links.
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup({
        mappings = nil,
      })
    end,
  },

  -- sorts completions prefixed with underscore lower since they aren't normally useful
  "lukas-reineke/cmp-under-comparator",

  -- adds indentation guides using virtual text
  {
    "echasnovski/mini.indentscope",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  -- provides various commands
  -- :Delete, :Move, :Rename, others...
  "tpope/vim-eunuch",

  -- supercharge <C-x> & <C-a> to increment words, like true/false, enabled/disabled
  "Konfekt/vim-CtrlXA",

  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({})
    end,
  },

  -- fancy notifications
  {
    "folke/noice.nvim",
    opts = {
      command_palette = false,
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- gc commenting
  {
    "echasnovski/mini.comment",
    config = function()
      require("mini.comment").setup()
    end,
  },

  -- easy movements via treesitter
  "ziontee113/SelectEase",

  -- linting
  "mfussenegger/nvim-lint",

  -- formatting
  "stevearc/conform.nvim",

  -- dash documentation app
  {
    "mrjones2014/dash.nvim",
    build = "make install",
  },

  -- nicer looking vim.ui.select
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
}, { git = { timeout = 600 } })

-- leave at bottom so packages can be installed before we try working with them
require("plugins/kanagawa")
-- require("plugins/lsp-zero")
require("plugins/lspsaga")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/lualine")
require("plugins/trouble")
require("plugins/snippets")
require("plugins/gitsigns")
require("plugins/diagnostics")
require("plugins/nvim-lint")
require("plugins/conform")
require("plugins/noice")
-- require("plugins/copilot")
