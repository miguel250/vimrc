local function get_mod_name(ctx)
  local handle = io.popen("go -C " .. ctx.dirname .. " list " .. ctx.dirname)
  if handle == nil then
    vim.notify("failed to run go command", vim.log.levels.ERROR)
    return ""
  end
  local result = vim.trim(handle:read("*a"))
  handle:close()
  if result == "" then
    return ""
  end
  local s = vim.split(result, "/")
  return s
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "goimports",
          "gofumpt",
        },
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports-reviser", "gofumpt" },
      },
      formatters = {
        ["goimports-reviser"] = {
          prepend_args = function(_, ctx)
            local mod = get_mod_name(ctx)
            local ret = { "-rm-unused", "-set-alias" }
            if type(mod) == "table" then
              local company_prefixes = mod[1]
              local size = vim.tbl_count(mod)
              if size >= 2 then
                company_prefixes = company_prefixes .. "/" .. mod[2]
              end

              table.insert(ret, "-company-prefixes")
              table.insert(ret, company_prefixes)

              if size >= 3 then
                table.insert(ret, "-project-name")
                table.insert(ret, vim.iter(mod):join("/"))
              end
            end
            return ret
          end,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              gofumpt = true,
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                fieldalignment = true,
              },
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              experimentalPostfixCompletions = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-node_modules" },
              semanticTokens = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
      },
    },
  },
}
