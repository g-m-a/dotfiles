-- The nvim-treesitter main branch stores queries in runtime/queries/ inside the
-- plugin directory, NOT at the plugin root. Neovim's rtp only includes the
-- plugin root, so we must add runtime/ explicitly so vim.treesitter can find
-- highlight/indent/fold queries. Running :TSUpdate will install them properly
-- into stdpath('data')/site/queries/ and this prepend becomes redundant.
local ts_runtime = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/runtime'
if vim.fn.isdirectory(ts_runtime) == 1 then
  vim.opt.rtp:prepend(ts_runtime)
end

-- Enable treesitter highlighting + indentation per filetype.
-- Uses pcall so filetypes without a parser are silently skipped.
-- Folding is intentionally left to nvim-ufo (see after/plugin/ufo.lua).
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ok = pcall(vim.treesitter.start)
    if not ok then return end
    -- Treesitter indent (experimental); disabled for Python as before
    if vim.bo.filetype ~= 'python' then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- after/plugin files load after the initial buffer's FileType event has already
-- fired, so apply highlighting retroactively to any buffers already open.
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
    pcall(vim.treesitter.start, buf)
    if vim.bo[buf].filetype ~= 'python' then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end
end

-- ---------------------------------------------------------------------------
-- Textobjects
-- ---------------------------------------------------------------------------
require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
  move   = { set_jumps = true },
}

local ts_select = require('nvim-treesitter-textobjects.select')
local ts_move   = require('nvim-treesitter-textobjects.move')
local ts_swap   = require('nvim-treesitter-textobjects.swap')

-- select
vim.keymap.set({ 'x', 'o' }, 'aa', function() ts_select.select_textobject('@parameter.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ia', function() ts_select.select_textobject('@parameter.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() ts_select.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() ts_select.select_textobject('@class.inner', 'textobjects') end)

-- move
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() ts_move.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() ts_move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() ts_move.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() ts_move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() ts_move.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() ts_move.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() ts_move.goto_previous_end('@class.outer', 'textobjects') end)

-- swap
vim.keymap.set('n', '<leader>a', function() ts_swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', '<leader>A', function() ts_swap.swap_previous('@parameter.inner') end)

-- ---------------------------------------------------------------------------
-- Treesitter context (unchanged API, still on master branch)
-- ---------------------------------------------------------------------------
require('treesitter-context').setup()
