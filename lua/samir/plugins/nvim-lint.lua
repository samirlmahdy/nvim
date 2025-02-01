return {
    "mfussenegger/nvim-lint",
    event = "BufWritePost", -- Run only on save
    opts = {
        -- Trigger linting only on file save
        events = { "BufWritePost" },
        linters_by_ft = {
            javascript = { "eslint", "prettier" },
            typescript = { "eslint", "prettier" },
            javascriptreact = { "eslint", "prettier" },
            typescriptreact = { "eslint", "prettier" },
        },
        -- Override linters to check for `.eslintrc`
        linters = {
            eslint = {
                condition = function(ctx)
                    -- Check if `.eslintrc` exists in the project root
                    return vim.fs.find({ ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml" },
                        { upward = true, path = ctx.dirname })[1]
                end,
            },
        },
    },
    config = function(_, opts)
        local lint = require("lint")

        -- Extend the default linters with conditions
        for name, linter in pairs(opts.linters) do
            if type(linter) == "table" and type(lint.linters[name]) == "table" then
                lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
            else
                lint.linters[name] = linter
            end
        end

        lint.linters_by_ft = opts.linters_by_ft

        -- Function to debounce linting
        local function debounce(ms, fn)
            local timer = vim.uv.new_timer()
            return function(...)
                local argv = { ... }
                timer:start(ms, 0, function()
                    timer:stop()
                    vim.schedule_wrap(fn)(unpack(argv))
                end)
            end
        end

        -- Function to run linters
        local function run_lint()
            local names = lint._resolve_linter_by_ft(vim.bo.filetype) or {}

            -- Add fallback linters
            if #names == 0 then
                vim.list_extend(names, lint.linters_by_ft["_"] or {})
            end

            -- Add global linters
            vim.list_extend(names, lint.linters_by_ft["*"] or {})

            -- Check if ESLint should run
            local ctx = { filename = vim.api.nvim_buf_get_name(0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

            names = vim.tbl_filter(function(name)
                local linter = lint.linters[name]
                return linter and (not linter.condition or linter.condition(ctx))
            end, names)

            -- Run the filtered linters
            if #names > 0 then
                lint.try_lint(names)
            end
        end

        -- Auto-lint on file save
        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = debounce(100, run_lint),
        })
    end,
}
