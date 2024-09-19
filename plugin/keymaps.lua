vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit VIM" }) -- exit insert mode with JK

-- Disable arrow keys
vim.keymap.set("i", "<Up>", "<NOP>")
vim.keymap.set("i", "<Down>", "<NOP>")
vim.keymap.set("i", "<Left>", "<NOP>")
vim.keymap.set("i", "<Right>", "<NOP>")

vim.keymap.set("n", "<Up>", "<NOP>", { noremap = true })
vim.keymap.set("n", "<Down>", "<NOP>", { noremap = true })
vim.keymap.set("n", "<Left>", "<NOP>", { noremap = true })
vim.keymap.set("n", "<Right>", "<NOP>", { noremap = true })

-- Switch between splits
vim.keymap.set("", "<C-j>", "<C-W>j", { desc = "Select down split" })
vim.keymap.set("", "<C-k>", "<C-W>k", { desc = "Select up split" })
vim.keymap.set("", "<C-h>", "<C-W>h", { desc = "Select left split" })
vim.keymap.set("", "<C-l>", "<C-W>l", { desc = "Select right split" })

-- Reload VIM configuration
vim.keymap.set("n", "<leader>r", ":so %<CR>", { desc = "Reload VIM configuration" })
