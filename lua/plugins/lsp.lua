return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            "b0o/schemastore.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "davidmh/cspell.nvim",
        },
        config = function()
            require "lsp"
        end,
    }
}
