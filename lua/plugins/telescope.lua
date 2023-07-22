return {
    {
        "nvim-telescope/telescope-fzf-native.nvim", build = 'make'
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = '0.1.x',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            require "telescope_config"
        end,
    },
}
