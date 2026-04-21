require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--follow",        -- Follow symbolic links
      "--hidden",        -- Search for hidden files
      "--no-heading",    -- Don't group matches by each file
      "--with-filename", -- Print the file path with the matched lines
      "--line-number",   -- Show line numbers
      "--column",        -- Show column numbers
      "--smart-case",    -- Smart case search
      "--no-ignore",     -- Don't respect .gitignore files

      -- Exclude some patterns from search
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
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      -- needed to exclude some files & dirs from general search
      -- when not included or specified in .gitignore
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--no-ignore", -- Don't respect .gitignore files
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
      },
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')
