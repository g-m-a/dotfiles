" treesitter stuff
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  autotag = {
    enable = true, -- nvim-ts-autotag
  },
  endwise = {
    enable = true, -- nvim-treesitter-endwise
  },
  highlight = {
    enable = true,
    disable = {},
    custom_captures = {},
  },
  -- gnn - start incremental selection
  -- grn - increment to upper named parent in visual mode
  -- grc - increment to upper scope in visual mode
  -- grm - decrement to previous named node in visual mode
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    enable = true,
    disable = {},
    select = {
      enable = true,
      lookahead = true, -- selects next available obj if not within one
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aP"] = { 
          -- a stretch, but "outer Proc" for Ruby; handles procs, blocks, and lambdas
          -- note that Ruby doesn't support @block.inner
          ruby = "@block.outer",
        },
      },
    },
  },
};

EOF
