return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            local root =
              lspconfig.util.root_pattern("typos.toml", "_typos.toml", ".typos.toml", "pyproject.toml")(fname)
            return root
          end,
          init_options = {
            cmd_env = { RUST_LOG = "error" },
            diagnosticSeverity = "Error",
          },
        },
      },
    },
  },
}
