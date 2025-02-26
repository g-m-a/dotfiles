-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Escape mappings
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Harpoon keymaps
local harpoon = require("harpoon")
vim.keymap.set('n', 'm', function() harpoon:list():add() end, {})
vim.keymap.set('n', 'mm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})
vim.keymap.set("n", "m1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "m2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "m3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "m4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "m5", function() harpoon:list():select(5) end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end
  vim.keymap.set('n', keys, func, { desc = desc })
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
