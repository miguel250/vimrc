local registry = require "mason-registry"

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "jsonls",
        "yamlls",
        "golangci_lint_ls",
        "gopls",
        "rust_analyzer",
        "pyright",
    },
}


local install_pkg = function(name)
    registry.refresh()
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() then
        pkg.install(pkg)
    end
end


install_pkg("isort")
install_pkg("write-good")

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
        require("null-ls").builtins.diagnostics.misspell,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.goimports.with({
            args = { "-rm-unused", "-srcdir", "$DIRNAME" },
        }),
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

local augroup_go_import = vim.api.nvim_create_augroup("goimports", { clear = true })
vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_go_import }
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_go_import,
    pattern = "*.go",
    callback = function(opt)
        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    end
})

local servers = {
    pyright = true,
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
        settings = {
            yaml = {
                validate = { enable = true },
                schemas = require('schemastore').yaml.schemas(),
                format = {
                    enable = true,
                },
                completion = true,
                customTags = {
                    "!fn",
                    "!And",
                    "!If",
                    "!Not",
                    "!Equals",
                    "!Or",
                    "!FindInMap sequence",
                    "!Base64",
                    "!Cidr",
                    "!Ref",
                    "!Ref Scalar",
                    "!Sub",
                    "!Or",
                    "!GetAtt",
                    "!GetAZs",
                    "!ImportValue",
                    "!Select",
                    "!Split",
                    "!Join sequence"
                },
            },
        },
    },
    rust_analyzer = {
        ['rust-analyzer'] = {
            imports = {
                granularity = {
                    group = 'module',
                },
                prefix = 'self',
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },
    }
}


local on_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local on_attach = function(client, bufnr)
    local bufopts = { nowait = true, noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', ':Telescope lsp_references jump_type=vsplit<cr>', bufopts)
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions jump_type=vsplit<cr>', bufopts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', 'lr', vim.lsp.buf.rename, bufopts)

    vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- highlighting is broken via lsp for these languages
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if filetype == "typescript" or filetype == "lua" then
        client.server_capabilities.semanticTokensProvider = nil
    end
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
