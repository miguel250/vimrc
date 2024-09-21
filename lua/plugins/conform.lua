return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    lazy = true,
    cmd = "ConformInfo",
    opts = function()
      return {
        default_format_opts = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
      }
    end,
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          -- local filename = vim.fn.expand "%:p"

          local extension = vim.fn.expand("%:e")
          if extension == "mlx" then
            return
          end

          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          })
        end,
      })
    end,
  },
}
