local servers = {
  clangd = {},
  bashls = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  jqls = {},
  jsonls = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  html = {},
  ts_ls = {
    telemetry = { enable = false },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false, library = {
        vim.env.VIMRUNTIME,
        vim.env.HOME .. '.local/share/nvim/lazy',
        vim.env.HOME .. '.local/share/nvim/mason/packages/*/lua'
      }},
      telemetry = { enable = false },
      runtime = { version = 'LuaJIT' },
    },
  },
  yamlls = {
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
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      settings = servers[server_name],
    }
  end,
}

mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), automatic_installation = false }
