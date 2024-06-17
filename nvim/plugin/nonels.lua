local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.nixfmt,
	},
})

--vim.keymap.set('n', '<C>f', lua vim.lsp.buf.format(), {})
-- Contoh command untuk memformat kode menggunakan LSP
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Space>ff", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
--vim.api.keymap.set("n", "<Space>f", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
