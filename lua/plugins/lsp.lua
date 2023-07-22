return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
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
