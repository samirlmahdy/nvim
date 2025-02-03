return{
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup {
      -- your custom configuration options
      -- For example:
      -- mode = "document_diagnostics", -- or "workspace_diagnostics"
      -- use_diagnostic_signs = true,
    }
  end,
}
