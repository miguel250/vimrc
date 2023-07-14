return {
 {
   "ellisonleao/gruvbox.nvim",
   lazy = false,
   priority = 100,
   config = function()
    require("gruvbox").setup({
	transparent_mode = true,
	contrast = "hard"
    })
    vim.cmd([[colorscheme gruvbox]])
   end
 }
}
