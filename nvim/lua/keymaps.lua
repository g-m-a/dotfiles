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
vim.keymap.set('n', 'm', require('harpoon.mark').add_file, {})
vim.keymap.set('n', 'mm', require("harpoon.ui").toggle_quick_menu, {})
vim.keymap.set('n', 'm1', function() require("harpoon.ui").nav_file(1) end, {})
vim.keymap.set('n', 'm2', function() require("harpoon.ui").nav_file(2) end, {})
vim.keymap.set('n', 'm3', function() require("harpoon.ui").nav_file(3) end, {})
vim.keymap.set('n', 'm4', function() require("harpoon.ui").nav_file(4) end, {})
vim.keymap.set('n', 'm5', function() require("harpoon.ui").nav_file(5) end, {})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
