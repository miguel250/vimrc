return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    commit = "b4da76b",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "-",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "Open file browser with path of the current buffer",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          file_ignore_patterns = { ".cache" },
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--color", "never", "-g", "!.git" },
            hidden = true,
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}
