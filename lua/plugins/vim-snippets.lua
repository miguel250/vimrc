return {
  {
    "garymjr/nvim-snippets",
    lazy = true,
    version = false,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
      },
      {
        "nvim-cmp",
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              -- Code from: https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/util/cmp.lua#L101
              local snippet = args.body
              local session = vim.snippet.active() and vim.snippet._session or nil

              local ok, err = pcall(vim.snippet.expand, snippet)
              if not ok then
                vim.print(err)
              end

              -- Restore top-level session when needed
              if session then
                vim.snippet._session = session
              end
            end,
          }
          table.insert(opts.sources, { name = "snippets" })
        end,
      },
    },
    opts = {
      friendly_snippets = true,
    },
  },
  {
    "nvim-cmp",
    keys = {
      {
        "<Tab>",
        function()
          return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
      {
        "<S-Tab>",
        function()
          return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
}
