local M = {}

-- Function to check if a plugin is installed
function M.is_plugin_installed(plugin_name)
  local plugin_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/' .. plugin_name
  return vim.fn.empty(vim.fn.glob(plugin_path)) == 0
end

-- Function to create a keymap with options
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Function to reload a module
function M.reload_module(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end

-- Function to print a table (for debugging purposes)
function M.print_table(tbl)
  print(vim.inspect(tbl))
end

return M
