return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!Base64 mapping",
                "!ImportValue mapping",
                "!And sequence",
                "!Equals sequence",
                "!GetAtt sequence",
                "!If sequence",
                "!FindInMap sequence",
                "!Join sequence",
                "!Not sequence",
                "!Or sequence",
                "!Select sequence",
                "!Sub sequence",
                "!Split sequence",
                "!Cidr sequence",
                "!Ref scalar",
                "!Sub scalar",
                "!GetAZs scalar",
                "!GetAtt scalar",
                "!Condition scalar",
                "!ImportValue scalar",
                "!Cidr scalar",
              },
            },
          },
        },
        vtsls = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              -- Define the diagnostic codes to filter out
              local filter_codes = { [80001] = true, [6192] = true, [6133] = true, [6196] = true }

              -- Filter diagnostics
              local filtered_diagnostics = {}
              for _, diagnostic in ipairs(result.diagnostics) do
                if not filter_codes[diagnostic.code] then
                  table.insert(filtered_diagnostics, diagnostic)
                end
              end

              -- Update the result with filtered diagnostics
              result.diagnostics = filtered_diagnostics

              -- Call the original handler
              vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
            end,
          },
        },
      },
    },
  },
}
