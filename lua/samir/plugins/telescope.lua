return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-q>"] = require("telescope.actions").send_selected_to_qflist +
                            require("telescope.actions").open_qflist,
                    },
                },
            })
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { noremap = true })
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { noremap = true })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true })
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, { noremap = true })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { noremap = true })

            require("telescope").load_extension("ui-select")
        end
    },
}
