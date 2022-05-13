" telescope + harpoon
lua require("telescope").load_extension('harpoon')
lua require('telescope').setup{ defaults = { file_ignore_patterns = { "*.pyc", "_build/*", "**/coverage/*", "**/node_modules/*", "**/.git/*", "**/obj/*", "**/bin/*", "^node_modules/", "^vendor/", "node_modules/.*"}, } }
