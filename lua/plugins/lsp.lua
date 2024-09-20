local on_attach = function(_, bufnr)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    buffer = bufnr,
    desc = "Goto Definition",
  })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, {
    buffer = bufnr,
    desc = "References",
    nowait = true,
  })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    buffer = bufnr,
    desc = "Hover",
  })
  vim.keymap.set("n", "lr", vim.lsp.buf.rename, {
    buffer = bufnr,
    desc = "Rename",
  })
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {
    buffer = bufnr,
    desc = "Go to previous diagnostic",
  })
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, {
    buffer = bufnr,
    desc = "Go to next diagnostic",
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = function()
      return {
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                diagnostics = {
                  globals = { "vim" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = on_attach,
        }, opts.servers[server] or {})

        require("lspconfig")[server].setup(server_opts)
      end

      local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      local _, mlsp = pcall(require, "mason-lspconfig")
      local plugin = require("lazy.core.config").spec.plugins["mason-lspconfig.nvim"]
      local mlsp_ensure_installed = require("lazy.core.plugin").values(plugin, "opts", false).ensure_installed
      mlsp.setup({
        ensure_installed = vim.tbl_deep_extend("force", ensure_installed, mlsp_ensure_installed or {}),
        handlers = { setup },
      })
    end,
  },
}
