local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.set_preferences({
  set_lsp_keymaps = false,
  -- suggest_lsp_servers = true,
  -- setup_servers_on_start = true,
  -- configure_diagnostics = true,
  -- cmp_capabilities = true,
  -- manage_nvim_cmp = true,
  -- sign_icons = {
  --   error = '✘',
  --   warn = '▲',
  --   hint = '⚑',
  --   info = ''
  -- }
})

-- add support for lua neovim config
lsp.nvim_workspace()

lsp.ensure_installed({
  'bashls',
  'cssmodules_ls',
  'elixirls',
  'jsonls',
  'sumneko_lua',
  'svelte',
  'tailwindcss',
  'tsserver',
  'yamlls'
})

-- disable formatters because we'll use null-ls
local on_attach_fn = function(client)
  client.resolved_capabilities.document_formatting = false
end

local lsp_configure = function(server, opts)
  opts.on_attach = on_attach_fn
  lsp.configure(server, opts)
end

lsp_configure('cssmodules_ls', {
  filetypes = {
    'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css',
    'scss', 'sass'
  }
})

lsp_configure('elixirls', {
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false
    }
  }
})

lsp_configure('sumneko_lua', {
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
      diagnostics = {globals = {'vim'}, disable = {'lowercase-global'}}
    }
  }
})

lsp.setup()
