local revision_num = require("revision").number
local revision_file = vim.fn.stdpath("data") .. "/plugin-revision-" .. revision_num .. ".txt"

if not vim.uv.fs_stat(revision_file) then
  local old_files = vim.fn.globpath(vim.fn.stdpath("data"), "plugin-revision-*.txt", true, true)
  for _, f in ipairs(old_files) do
    vim.fn.delete(f)
  end

  local has_nvim_treesitter, _ = pcall(require, "nvim-treesitter")
  if has_nvim_treesitter then
    local treesitter_parsers = vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/*", true, true)
    if type(treesitter_parsers) == "table" then
      for _, f in ipairs(treesitter_parsers) do
        vim.fn.delete(f)
      end
    end
  end

  vim.fn.system({
    "touch",
    revision_file,
  })

  require("lazy").restore()
  require("lazy").clean()
end
