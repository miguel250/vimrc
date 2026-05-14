local on_attach = function(_, bufnr)
  vim.keymap.set("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true, jump_type = "vsplit" })
  end, {
    buffer = bufnr,
    desc = "Goto Definition",
  })
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
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
  vim.keymap.set("n", "<leader>dp", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, {
    buffer = bufnr,
    desc = "Go to previous diagnostic",
  })
  vim.keymap.set("n", "<leader>dn", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, {
    buffer = bufnr,
    desc = "Go to next diagnostic",
  })
  vim.keymap.set("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end, {
    buffer = bufnr,
    desc = "Goto Implementation",
  })
  vim.keymap.set("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, {
    buffer = bufnr,
    desc = "Goto T[y]pe Definition",
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = function()
      vim.lsp.log.set_level("off")
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
                  underline = true,
                  update_in_insert = false,
                  virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    -- prefix = "icons",
                  },
                  severity_sort = true,
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
        setup = {},
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

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mlsp_servers = have_mason and vim.tbl_keys(mlsp.get_mappings().lspconfig_to_package) or {}
      local exclude_automatic_enable = {}

      local function configure(server, config)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = on_attach,
        }, config)

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return true
          end
        end

        vim.lsp.config(server, server_opts)

        if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
          vim.lsp.enable(server)
          return true
        end

        return false
      end

      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        server_opts = server_opts == true and {} or server_opts
        if server_opts == false or server_opts.enabled == false or configure(server, server_opts) then
          exclude_automatic_enable[#exclude_automatic_enable + 1] = server
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      local plugin = require("lazy.core.config").spec.plugins["mason-lspconfig.nvim"]
      local mlsp_ensure_installed = require("lazy.core.plugin").values(plugin, "opts", false).ensure_installed
      local combined = vim.list_extend(vim.deepcopy(ensure_installed), mlsp_ensure_installed or {})
      local deduped = {}
      local seen = {}
      for _, server in ipairs(combined) do
        if not seen[server] then
          seen[server] = true
          deduped[#deduped + 1] = server
        end
      end
      if have_mason then
        mlsp.setup({
          ensure_installed = deduped,
          automatic_enable = {
            exclude = exclude_automatic_enable,
          },
        })
      end
    end,
  },
}
