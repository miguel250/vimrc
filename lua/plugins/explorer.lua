local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this Too

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            disable_netrw = true,
            hijack_netrw = true,
            respect_buf_cwd = true,
            sync_root_with_cwd = true,
            filters = {
                dotfiles = true,
            },
            view = {
                relativenumber = true,
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                            - vim.opt.cmdheight:get()
                        return {
                            border = "rounded",
                            relative = "editor",
                            row = center_y,
                            col = center_x,
                            width = window_w_int,
                            height = window_h_int,
                        }
                    end,
                },
                width = function()
                    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                end,
            },
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')

                local function opts(desc)
                    return {
                        desc = 'nvim-tree: ' .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set('n', '<cr>', api.node.open.vertical, opts('Open: Vertical Split'))
                vim.keymap.set('n', '<leader>-', api.tree.close)
                vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
                vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
            end
        })
    end
}
