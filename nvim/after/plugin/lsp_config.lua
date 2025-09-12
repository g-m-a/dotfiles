local servers = {
  clangd = {},
  bashls = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  jqls = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },
  pyright = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  html = {},
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          importModuleSpecifierPreference = "relative",
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          importModuleSpecifierPreference = "relative",
        }
      }
    }
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            vim.env.HOME .. '/.local/share/nvim/lazy',
            vim.env.HOME .. '/.local/share/nvim/mason/packages/*/lua'
          }
        },
        telemetry = { enable = false },
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          globals = { 'vim' },
        },
        completion = {
          callSnippet = "Replace"
        },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
        redhat = {
          telemetry = false,
        },
        schemaStore = {
          enable = true,
        },
      },
    },
  },
}

-- Setup capabilities for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Setup Mason
require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Setup LSP through Mason
local mason_lspconfig = require('mason-lspconfig')

-- Ensure specified servers are installed
mason_lspconfig.setup({
  automatic_enable = true,
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
})
