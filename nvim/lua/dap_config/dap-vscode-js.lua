require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      -- processId = require'dap.utils'.pick_process({ filter = "node --inspect" }),
      processId = function ()
        require('dap.utils').pick_process({ filter = function(proc)
              if string.find(proc.name, "--inspect" ) > 0 then
                  return true
              end
              return false
          end
        })
      end,
      name = "Attach process",
      sourceMaps = true,
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**"
      },
      cwd = "${workspaceFolder}/src",
      skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    },
    language == "javascript" and {
      type = "pwa-node",
      request = "launch",
      name = "Launch file in new node process",
      program = "${file}",
      cwd = "${workspaceFolder}",
    } or nil,
  }
end
