return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim", "mfussenegger/nvim-lint" }, -- Added `nvim-lint` for linting
    lazy = true,
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cF",
            function()
                require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
    },
    opts = {
        format_on_save = function(bufnr)
            -- Run linters first
            require("lint").try_lint()
            -- Then format the file
            require("conform").format({ bufnr = bufnr })
        end,
        default_format_opts = {
            timeout_ms = 3000,
            async = true,
            quiet = false,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            fish = { "fish_indent" },
            sh = { "shfmt" },
            typescript = { "eslint_d" },
            javascript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            javascriptreact = { "eslint_d" },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
            eslint = {
                condition = function(ctx)
                    -- Ensure ESLint runs only if a config file exists
                    return vim.fs.find(
                        { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml" },
                        { upward = true, path = ctx.dirname }
                    )[1]
                end,
            },
        },
    },
    config = function(_, opts)
        require("conform").setup(opts)

        -- Auto-format and lint before saving
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                require("lint").try_lint()
                require("conform").format()
            end,
        })
    end,
}
