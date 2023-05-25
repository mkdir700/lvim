local M = {}

M.config = function()
	require("leap").setup({
		vim.api.nvim_set_keymap("n", "s", "<Plug>(leap-forward-to)", { silent = true }),
		vim.api.nvim_set_keymap("n", "S", "<Plug>(leap-backward-to)", { silent = true }),
	})
end

return M
