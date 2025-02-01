
-- leader key
vim.g.mapleader = " "

local keymaps = vim.keymap

keymaps.set("n","<leader>pv", vim.cmd.Ex)
keymaps.set("n","<C-d>","<C-d>zz")
keymaps.set("n","<C-u>","<C-u>zz")
keymaps.set("n","n","nzzzv")
keymaps.set("n","N","Nzzzv")


-- Navigate vim panes better
keymaps.set('n', '<c-k>', ':wincmd k<CR>')
keymaps.set('n', '<c-j>', ':wincmd j<CR>')
keymaps.set('n', '<c-h>', ':wincmd h<CR>')
keymaps.set('n', '<c-l>', ':wincmd l<CR>')

keymaps.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
