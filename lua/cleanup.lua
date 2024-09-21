local revision_num = require("revision").number
local revision_file = vim.fn.stdpath("data") .. "/plugin-revision-" .. revision_num .. ".txt"
local cleanup_triggered = false

if not vim.uv.fs_stat(revision_file) then
  local old_files = vim.fn.globpath(vim.fn.stdpath("data"), "plugin-revision-*.txt", true, true)
  for _, f in ipairs(old_files) do
    vim.fn.delete(f)
  end

  if vim.uv.fs_stat(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser") then
    local treesitter_parsers = vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/*", true, true)
    if type(treesitter_parsers) == "table" then
      vim.print(treesitter_parsers)
      for _, f in ipairs(treesitter_parsers) do
        vim.fn.delete(f)
      end
    end
  end

  if vim.uv.fs_stat(vim.fn.stdpath("data") .. "/mason") then
    local mason_packages = vim.fn.stdpath("data") .. "/mason"
    vim.fn.delete(mason_packages, "rf")
  end

  vim.fn.system({
    "touch",
    revision_file,
  })

  cleanup_triggered = true
end
return cleanup_triggered
