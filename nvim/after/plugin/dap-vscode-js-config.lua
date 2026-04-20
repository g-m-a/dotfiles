-- Handle VSCode JS Debug gracefully
local status_dap, dap = pcall(require, 'dap')
if not status_dap then
  vim.notify('DAP not installed, skipping JavaScript/TypeScript DAP setup', vim.log.levels.WARN)
  return
end

local status_dap_vscode_js, dap_vscode_js = pcall(require, 'dap-vscode-js')
if not status_dap_vscode_js then
  vim.notify('dap-vscode-js not installed, skipping JavaScript/TypeScript DAP setup', vim.log.levels.WARN)
  return
end

-- Check if the debugger path exists
local debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
if vim.fn.isdirectory(debugger_path) == 0 then
  vim.notify('VSCode JS debugger not found at ' .. debugger_path ..
    '. Run `:Lazy sync` and ensure microsoft/vscode-js-debug is installed.', vim.log.levels.WARN)
  return
end

-- Setup the JavaScript debugger
dap_vscode_js.setup({
  debugger_path = debugger_path,
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- Configure JavaScript/TypeScript debugging
for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
  dap.configurations[language] = {
    -- Attach to a Node.js process
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Process",
      processId = function()
        return require('dap.utils').pick_process({
          filter = function(proc)
            return proc.name and proc.name:find("node") ~= nil and proc.name:find("--inspect") ~= nil
          end
        })
      end,
      sourceMaps = true,
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**"
      },
      cwd = "${workspaceFolder}",
      skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    },
    -- Launch a JavaScript file in Node.js
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch File (Node.js)",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
    -- Debug Next.js
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Next.js",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "npm",
      runtimeArgs = { "run", "dev" },
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      console = "integratedTerminal",
    },
    -- Debug tests with Jest
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/jest",
      runtimeArgs = { "--runInBand" },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
    -- Debug in Chrome browser
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "**/node_modules/**/*" },
    },
  }
end

