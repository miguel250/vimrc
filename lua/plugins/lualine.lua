return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lsp_info = function()
      local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return "No Active Lsp"
      end

      local ret = {}
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          table.insert(ret, client.name)
        end
      end
      return vim.iter(ret):join("|")
    end

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "catppuccin-frappe",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
      },
      sections = {
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 3,
            shorting_target = 40,
            separator = nil,
          },
        },
        lualine_x = {
          {
            lsp_info,
            icon = ":",
          },
          "encoding",
          "filetype",
        },
      },
    })
  end,
}
