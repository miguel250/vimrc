return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "go",
                    "gomod",
                    "bash",
                    "html",
                    "javascript",
                    "json",
                    "markdown",
                    "python",
                    "query",
                    "rust",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<space>",   -- maps in normal mode to init the node/scope selection with space
                        node_incremental = "<space>", -- increment to the upper named parent
                        node_decremental = "<bs>",    -- decrement to the previous node
                        scope_incremental = "<tab>",  -- increment to the upper scope (as defined in locals.scm)
                    },
                },
                autopairs = {
                    enable = true,
                },
                highlight = {
                    enable = true,

                    -- Disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    additional_vim_regex_highlighting = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ["iB"] = "@block.inner",
                            ["aB"] = "@block.outer",
                            ["av"] = "@variable.outer",
                            ["iv"] = "@variable.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']]'] = '@function.outer',
                        },
                        goto_next_end = {
                            [']['] = '@function.outer',
                        },
                        goto_previous_start = {
                            ['[['] = '@function.outer',
                        },
                        goto_previous_end = {
                            ['[]'] = '@function.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_previous = {
                            ['<leader>sp'] = '@parameter.inner',
                        },
                        swap_next = {
                            ['<leader>sn'] = '@parameter.inner',
                        },
                    },
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                    config = {
                        c = "// %s",
                        lua = "-- %s",
                    },
                },
            })
        end
    }
}
