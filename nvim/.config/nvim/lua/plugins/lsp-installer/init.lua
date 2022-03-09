-- TODO clean up this dumping ground
local lsp_installer = require 'nvim-lsp-installer'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

-- Include the servers you want to have installed by default below
local servers = {
  'svelte', 'elixirls', 'cssmodules_ls', 'tailwindcss', 'yamlls', 'tsserver',
  'gopls', 'bashls', 'sumneko_lua'
}

local cmp = require 'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  experimental = {ghost_text = true},
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-y>'] = cmp.config.disable, -- remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'})
  },
  sources = cmp.config.sources({{name = 'luasnip'}, {name = 'nvim_lsp'}},
                               {{name = 'buffer'}}),
  formatting = {
    format = require('lspkind').cmp_format({
      with_text = false,
      menu = {nvim_lsp = '[LSP]'}
    })
  }
})

-- see: https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print('Installing ' .. name)
      server:install()
    end
  end
end

-- show long diagnostic inlines in a float
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus = false, border = "single"})]]
-- disable inline diagnostics
vim.diagnostic.config({virtual_text = false, update_in_insert = true})

local function on_attach(client, bufnr)
  -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
  vim.api.nvim_echo({
    {
      'Attached ' .. client.name .. ' LSP server to ' .. vim.fn.bufname(bufnr),
      'None'
    }
  }, false, {})
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api
        .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync({},1500)]]
    vim.api.nvim_command [[augroup END]]
  end
end

local enhance_server_opts = {
  -- Provide settings that should only apply to the "eslintls" server
  ['elixirls'] = function(opts)
    opts.settings = {elixirLS = {dialyzerEnabled = false, fetchDeps = false}}
  end,
  -- ['efm'] = function(opts)
  --   opts.init_options = {
  --     documentFormatting = true,
  --     hover = true,
  --     documentSymbol = true,
  --     codeAction = true,
  --     completion = true
  --   }
  --   opts.filetypes = {
  --     'elixir', 'lua', 'svelte', 'yaml', 'javascript', 'javascriptreact',
  --     'javascript.jsx', 'typescript', 'typescript.tsx', 'typescriptreact'
  --   }
  -- end,
  ['cssmodules_ls'] = function(opts)
    opts.filetypes = {
      'javascript', 'javascriptreact', 'typesscript', 'typescriptreact', 'css',
      'scss', 'sass'
    }
  end,
  ['yamlls'] = function(opts)
    opts.yaml = {
      format = {
        enable = true,
        singleQuote = true,
        bracketSpacing = true,
        printWidth = 80
      }
    }
  end,
  ['svelte'] = function(opts)
    opts.svelte = {format = {enable = false}}
  end,
  ['sumneko_lua'] = function(opts)
    opts.settings = {
      Lua = {
        runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
        diagnostics = {globals = {'vim'}, disable = {'lowercase-global'}}
      }
    }
  end,
  ['tsserver'] = function(opts)
    opts.typescript = {format = {enable = false}}
    opts.javascript = {suggestionActions = {enabled = false}}
  end
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local opts = {on_attach = on_attach, capabilities = capabilities}

  if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)

