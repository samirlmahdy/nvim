return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Use ESLint_D as a formatter (or use prettier if you prefer)
                null_ls.builtins.formatting.eslint_d,
                -- or, for Prettier:
                -- null_ls.builtins.formatting.prettier,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    -- Create an augroup so the autocmd is cleared on detach
                    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
