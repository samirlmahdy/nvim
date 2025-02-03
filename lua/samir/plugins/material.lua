-- Lazy
return {
    "vague2k/vague.nvim",
    prioirty = 1000,
    config= function ()
        vim.defer_fn(function()
            vim.cmd("colorscheme vague")
        end, 50) -- Delay execution slightly to prevent NeoTree errors
    end
}

