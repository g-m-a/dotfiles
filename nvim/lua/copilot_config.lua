require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 200,
    keymap = {
      accept = "<S-Right>",
      next = "<S-Down>",
      prev = "<S-Up>",
      dismiss = "<S-Esc>",
    }
  },
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<S-Left>"
    },
    layout = {
      position = "right", -- | top | left | right
      ratio = 0.2
    },
  },
})
