local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>qgI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>qgD', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>qgd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>gD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

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
      keyOrdering = false
    },
  },
  eslint = {
    useFlatConfig = true,
    experimental = {
      useFlatConfig = nil,
    },
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

require('fidget').setup()
