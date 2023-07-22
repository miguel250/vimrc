local actions = require "telescope.actions"
local telescope = require "telescope"

telescope.setup {
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    multi_icon = "<>",

    winblend = 0,

    layout_strategy = "horizontal",
    layout_config = {
        width = 0.95,
        height = 0.85,
        prompt_position = "top",

        horizontal = {
            preview_width = function(_, cols, _)
                if cols > 200 then
                    return math.floor(cols * 0.4)
                else
                    return math.floor(cols * 0.6)
                end
            end,
        },

        vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
        },

        flex = {
            horizontal = {
                preview_width = 0.9,
            },
        },
    },
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_vertical,
            },
            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_vertical,
            }
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        fzf_writer = {
            use_highlighter = false,
            minimum_grep_characters = 6,
        },
        file_browser = {
            hijack_netrw = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            },
        },
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
}

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>fg', builtin.git_files, {})
vim.keymap.set('n', '<space>fd', builtin.find_files, {})
vim.keymap.set('n', '<space>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>gs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, {})
vim.keymap.set('n', '-', '<cmd>Telescope file_browser<CR>', { silent = true, noremap = true })
