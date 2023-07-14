local revision_num = require("revision").number
local revision_file = vim.fn.stdpath "data" .. "/" .. revision_num .. ".txt"

if not vim.loop.fs_stat(revision_file) then
  local old_files = vim.fn.globpath(vim.fn.stdpath "data", "*.txt", true, true)
  for _, f in ipairs(old_files) do
    vim.fn.delete(f)
  end

  print("Installing plugins")
  vim.fn.system {
    "touch",
    revision_file,
  }
  require("lazy").restore()
end



