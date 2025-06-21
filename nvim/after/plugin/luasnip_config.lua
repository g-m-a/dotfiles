local ok, luasnip_loaders = pcall(require, "luasnip.loaders.from_vscode")
if not ok then
  vim.notify("LuaSnip loaders not found, skipping VSCode snippet loading", vim.log.levels.WARN)
  return
end

-- Load snippets from friendly-snippets
luasnip_loaders.lazy_load()

-- Load custom snippets if they exist
local custom_snippets_path = vim.fn.stdpath("config") .. "/snippets"
if vim.fn.isdirectory(custom_snippets_path) == 1 then
  luasnip_loaders.load({ paths = { custom_snippets_path } })
end

-- Setup luasnip basic options
local ok_luasnip, ls = pcall(require, "luasnip")
if ok_luasnip then
  ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = { { "⬅️", "GruvboxOrange" } }
        }
      }
    }
  })
end