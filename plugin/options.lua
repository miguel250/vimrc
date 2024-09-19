local opt = vim.opt

opt.encoding = "utf-8"
opt.termguicolors = true
opt.belloff = "all" -- Just turn the dang bell off
opt.spell = true
vim.opt.colorcolumn = "80"

opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.swapfile = false

opt.formatoptions:remove("o")

opt.wrap = true
opt.linebreak = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.swapfile = false

-- persistent undo
opt.undofile = true
opt.undodir = "/tmp/vim"

-- disable mouse
opt.mouse = ""
