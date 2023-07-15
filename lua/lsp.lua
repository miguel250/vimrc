require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "jsonls",
        "yamlls",
        "golangci_lint_ls",
        "gopls",
    },
}


local registry = require "mason-registry"
local ok, pkg = pcall(registry.get_package, "write-good")
if ok and not pkg:is_installed() then
    pkg.install(pkg)
end

require("neodev").setup {
    override = function(_, library)
        library.enabled = true
        library.plugins = true
    end,
    lspconfig = true,
    pathStrict = true,
}

require("null-ls").setup {
    sources = {
        require("null-ls").builtins.diagnostics.write_good,
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
    },
}

-- Auto format failure
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
        vim.lsp.buf.format { async = false }
    end,
})

local servers = {
    golangci_lint_ls = true,
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
        }
    },
    lua_ls = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
    yamlls = {
        yaml = {
            validate = { enable = true },
            schemas = require('schemastore').yaml.schemas(),
        },
    }
}


local on_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', 'lr', vim.lsp.buf.rename, bufopts)

    vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())

local lspconfig = require("lspconfig")
local setup_server = function(server, config)
    if type(config) ~= "table" then
        config = {}
    end
    config = vim.tbl_deep_extend("force", {
        on_init = on_init,
        on_attach = on_attach,
        capabilities = updated_capabilities,
    }, config)
    lspconfig[server].setup(config)
end


for server, config in pairs(servers) do
    setup_server(server, config)
end
