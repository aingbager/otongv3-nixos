require("bufferline").setup({})
--vim.cmd([[
--noremap <silent><TAB> :BufferLineCycleNext<CR>
--noremap <silent><S-TAB> :BufferLineCyclePrev<CR>
--]])

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)
map('n', '<S-Tab>', ':BufferLineCycleNext<CR>', opts)
map('n', '<leader>q', ':bdelete<CR>', opts)
