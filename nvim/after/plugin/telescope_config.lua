local glob_exclusions = {
  "--glob=!**/.git/*",
  "--glob=!**/.git",
  "--glob=!**/.idea/*",
  "--glob=!**/.vscode/*",
  "--glob=!**/.next/*",
  "--glob=!**/build/*",
  "--glob=!**/dist/*",
  "--glob=!**/node_modules/*",
  "--glob=!**/yarn.lock",
  "--glob=!**/bun.lockb",
  "--glob=!**/package-lock.json",
}

require('telescope').setup {
  defaults = {
    preview = {
      -- Neovim 0.12 stricty validates treesitter queries; a parser/query
      -- version mismatch causes "Impossible pattern" errors in the previewer.
      -- Disable treesitter highlighting here and rely on regex-based syntax
      -- instead. Re-enable after running :Lazy update + :TSUpdate.
      treesitter = false,
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    vimgrep_arguments = vim.list_extend({
      "rg",
      "--follow",        -- Follow symbolic links
      "--hidden",        -- Search for hidden files
      "--no-heading",    -- Don't group matches by each file
      "--with-filename", -- Print the file path with the matched lines
      "--line-number",   -- Show line numbers
      "--column",        -- Show column numbers
      "--smart-case",    -- Smart case search
      "--no-ignore",     -- Don't respect .gitignore files
    }, vim.deepcopy(glob_exclusions)),
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = vim.list_extend({
        "rg",
        "--files",
        "--hidden",
        "--no-ignore", -- Don't respect .gitignore files
      }, vim.deepcopy(glob_exclusions)),
    },
  },
}
-- fzf extension is loaded by lazy.nvim via the plugin's config function
