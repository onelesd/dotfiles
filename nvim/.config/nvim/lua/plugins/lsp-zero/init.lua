local lsp = require("lsp-zero")
local lsp_ts_utils = require('nvim-lsp-ts-utils')

lsp.preset("recommended")
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
	"bashls",
	"cssmodules_ls",
	"elixirls",
	"jsonls",
	"sumneko_lua",
	"svelte",
	"tailwindcss",
	"tsserver",
	"yamlls",
})

-- disable formatters because we'll use null-ls
local on_attach_fn = function()
  -- setting formatting capabilities to false makes null-ls the only option
	-- client.resolved_capabilities.document_formatting = false
	-- client.resolved_capabilities.document_range_formatting = false
  -- autocmd BufWritePre <buffer> LspZeroFormat
	vim.cmd([[
    augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync({},3000)
    augroup END
  ]])
end

local lsp_configure = function(server, opts)
  if opts.on_attach ~= nil then
    opts.on_attach = on_attach_fn
  end
	lsp.configure(server, opts)
end

lsp_configure("cssmodules_ls", {
	filetypes = {
		"javascript",
		"typescript",
		"css",
	},
})

lsp_configure("elixirls", {
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
			fetchDeps = false,
		},
	},
})

lsp_configure("sumneko_lua", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			diagnostics = { globals = { "vim" }, disable = { "lowercase-global" } },
		},
	},
})

lsp.configure("tsserver", {
  on_attach = function(client)
    vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync({},3000)
      augroup END
    ]])

    lsp_ts_utils.setup({
      debug = false,
      -- disable_commands = false,
      enable_import_on_completion = true,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      -- if false will avoid organizing imports
      always_organize_imports = true,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {
        -- filter this message as it is basically never useful
        -- File is a CommonJS module; it may be converted to an ES module. typescript (80001)
        80001
      },

      -- inlay hints
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
      inlay_hints_format = { -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
        -- Example format customization for `Type` kind:
        -- Type = {
        --     highlight = "Comment",
        --     text = function(text)
        --         return "->" .. text:sub(2)
        --     end,
        -- },
      },

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })

    -- required to fix code action ranges and filter diagnostics
    lsp_ts_utils.setup_client(client)
  end
})

lsp.setup()
