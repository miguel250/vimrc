vim.g.mapleader = ","
vim.g.maplocalleader = " "

require "disable_builtin"
local base_dir = (function()
    local init_path = debug.getinfo(1, "S").source
    return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
  end)()

local plugin_file = vim.fn.stdpath("config") .. "/plugins.json"
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }

  if vim.loop.fs_stat(plugin_file) then
    local snapshot = assert(vim.fn.json_decode(vim.fn.readfile(plugin_file)))
    -- Install version found in plugin file
    vim.fn.system {
      "git",
      "-C",
      lazypath,
      "checkout",
      snapshot["lazy.nvim"].commit,
    }
  end
end

vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("plugins", {
 lockfile = plugin_file,
})
