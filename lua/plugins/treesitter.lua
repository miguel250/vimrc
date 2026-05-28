return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    version = false,
    lazy = false,
    event = "BufRead",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "andymass/vim-matchup" },
    },
    opts_extend = { "ensure_installed" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSModuleInfo" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      folds = { enable = true },
      ensure_installed = {
        "lua",
        "luadoc",
        "luap",
        "vim",
        "vimdoc",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      if not TS.get_installed then
        print("Restart vim and run :TSUpdate")
        return
      end
      TS.setup(opts)

      local installed = TS.get_installed()
      local install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, opts.ensure_installed or {})

      if #install > 0 then
        TS.install(install, { summary = true })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mode = "cursor",
      max_lines = 3,
    },
  },
}
