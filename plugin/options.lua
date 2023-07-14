local opt = vim.opt

opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append { "Cargo.lock", "Cargo.Bazel.lock" }
opt.wildignore:append { "go.sum" }

opt.showmode = false
opt.showcmd = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.number = true -- But show the actual number for the line we're on

opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 1000 -- Make updates happen faster

opt.scrolloff = 10 -- Make it so there are always ten lines below cursor

opt.clipboard = "unnamedplus"

-- persistent undo
opt.undofile = true
opt.undodir = "/tmp/vim"

opt.signcolumn = "yes"
