return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    lazy = true,
    cmd = "ConformInfo",
    opts = function()
      local default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      }
      return {
        default_format_opts = default_format_opts,
        format_on_save = function(bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local extension = vim.fn.fnamemodify(filename, ":e")
          if extension == "mlx" then
            return false
          end
          return vim.deepcopy(default_format_opts)
        end,
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
    end,
  },
}
