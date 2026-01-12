return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = true,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        default_integrations = true,
        integrations = {
          treesitter = true,
          which_key = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
