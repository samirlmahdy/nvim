-- Basic settings

local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.ignorecase = true
opt.nu = true
opt.relativenumber = true
opt.wrap = false
opt.incsearch = true
opt.swapfile = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.background="dark"
opt.termguicolors = true
opt.pumblend = 0
opt.scrolloff = 0 -- Disable smooth scrolling
opt.sidescrolloff = 0
vim.g.autoformat = true
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright=true
opt.splitbelow=true


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  callback = function()
    vim.cmd("lua vim.lsp.buf.format()")
  end,
})

