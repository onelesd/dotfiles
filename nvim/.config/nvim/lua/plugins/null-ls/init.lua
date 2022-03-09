local null_ls = require("null-ls")
local builtins = null_ls.builtins
local formatting = builtins.formatting
local diagnostics = builtins.diagnostics
local code_actions = builtins.code_actions
local command_resolver = null_ls.command_resolver
local sources = {
  -- diagnostics.eslint.with({
  --   condition = function(utils) -- truthy use source, falsy don't
  --     return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
  --   end,
  --   filetypes = { "html", "json", "yaml", "markdown" }
  --   extra_filetypes = { "toml" }
  --   disabled_filetypes = { "lua" }
  --   extra_args = { "-i", "2", "-ci" }
  --   args = { "only", "my", "args", "please" }
  --   env = {
  --     PRETTIERD_DEFAULT_CONFIG = vim.fn.expand "~/.config/nvim/utils/linter-config/.prettierrc.json",
  --   }
  --   diagnostics_format = "[#{c}] #{m} (#{s})"
  --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE -- if live diagnostics are slow, do it on save only
  --   timeout = 10000 -- milliseconds; if things take too long we can abort
  --   prefer_local = "node_modules/.bin" -- look for local binaries here instead of global
  --   only_local = true -- some options as prefer_local; don't look for global at all
  --   command = "/path/to/prettier" -- explicit path
  --   dynamic_command = function(params)
  --     return command_resolver.from_node_modules(params) -- try node_modules
  --            or command_resolver.from_yarn_pnp(params) -- then a yarn plug n play
  --            or vim.fn.executable(params.command) == 1 and params.command -- then global
  --   end
  -- })

  formatting.eslint_d.with({
    filetypes = { "javascript", "typescript", "svelte" },
  }),
  -- formatting.mix.with({
  --   filetypes = { "elixir" },
  --   prefer_local = true,
  -- }),
  formatting.prettier.with({
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "json",
      "yaml",
      "markdown",
      "svelte",
    },
    only_local = true,
    command = "assets/node_modules/.bin/prettier",
    extra_args = { "--config", "assets/.prettierrc.json" }
  }),
  formatting.rustywind.with({
    filetypes = { "javascript", "typescript", "svelte" },
  }),
  formatting.shellharden.with({
    filetypes = { "sh" },
  }),
  formatting.shfmt.with({
    filetypes = { "sh" },
  }),
  formatting.stylua.with({
    filetypes = { "lua" },
    extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
  }),
  formatting.surface.with({
    filetypes = { "elixir", "surface" },
  }),
  diagnostics.credo.with({
    filetypes = { "elixir" },
    args = { "credo", "--strict", "--format", "json", "--read-from-stdin", "$FILENAME" }
  }),
  diagnostics.editorconfig_checker.with({
    filetypes = {},
    command = "editorconfig",
  }),
  diagnostics.eslint_d.with({
    filetypes = { "javascript", "typescript", "svelte" },
    only_local = true,
    -- should adapt this to work with any project tree with dynamic_command
    command = "assets/node_modules/.bin/eslint_d",
    extra_args = { "-c", "assets/.eslintrc.js", "--ignore-path", "assets/.eslintignore" }
  }),
  code_actions.eslint_d.with({
    filetypes = { "javascript", "typescript", "svelte" },
    only_local = true,
    -- should adapt this to work with any project tree with dynamic_command
    command = "assets/node_modules/.bin/eslint_d",
    extra_args = { "-c", "assets/.eslintrc.js", "--ignore-path", "assets/.eslintignore" }
  }),
  diagnostics.gitlint.with({
    filetypes = { "gitcommit" },
  }),
  diagnostics.hadolint.with({
    filetypes = { "dockerfile" },
  }),
  diagnostics.jsonlint.with({
    filetypes = { "json" },
  }),
  diagnostics.luacheck.with({
    filetypes = { "lua" },
  }),
  diagnostics.markdownlint.with({
    filetypes = { "markdown" },
  }),
  diagnostics.proselint.with({
    filetypes = { "markdown" },
  }),
  diagnostics.selene.with({
    filetypes = { "lua" },
  }),
  diagnostics.shellcheck.with({
    filetypes = { "sh" },
  }),
  diagnostics.stylelint.with({
    filetypes = { "css" },
    only_local = true,
    command = "assets/node_modules/.bin/stylelint",
    extra_args = {"--config", "assets/.stylelintrc.json"}
  }),
  diagnostics.write_good.with({
    filetypes = { "markdown" },
  }),
  diagnostics.zsh.with({
    filetypes = { "zsh" },
  }),
  diagnostics.tsc.with({
    filetypes = { "typescript" },
  }),
  code_actions.gitsigns.with({
    filetypes = {},
  }),
  code_actions.proselint.with({
    filetypes = { "markdown" },
  }),
  code_actions.refactoring.with({
    -- Requires visually selecting the code you want to refactor and calling
    -- :'<,'>lua vim.lsp.buf.range_code_action() (for the default handler) or
    -- :'<,'>Telescope lsp_range_code_actions (for Telescope).
    filetypes = { "javascript", "typescript", "lua" },
  }),
}

null_ls.setup({
  sources = sources,
  debug = true
})
