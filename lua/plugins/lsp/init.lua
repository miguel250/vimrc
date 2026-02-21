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
      { "mason-org/mason.nvim", version = "^1.0.0" },
      { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
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

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = on_attach,
        }, opts.servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        end

        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
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
      local combined = vim.list_extend(vim.deepcopy(ensure_installed), mlsp_ensure_installed or {})
      local deduped = {}
      local seen = {}
      for _, server in ipairs(combined) do
        if not seen[server] then
          seen[server] = true
          deduped[#deduped + 1] = server
        end
      end
      mlsp.setup({
        ensure_installed = deduped,
        handlers = { setup },
      })
    end,
  },
}
