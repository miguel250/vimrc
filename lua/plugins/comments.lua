return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                -- LHS of operator-pending mapping in NORMAL + VISUAL mode
                opleader = {
                    -- line-comment keymap
                    line = "gc",
                    -- block-comment keymap
                    block = "gb",
                },

                -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                mappings = {
                    basic = true,
                    extra = true,
                },

                toggler = {
                    line = "gcc",
                    block = "gbc",
                },

            }

            local comment_ft = require "Comment.ft"
            comment_ft.set("lua", { "--%s", "--[[%s]]" })
        end,
    },
}
