local M = {}

M.config = function()
	require("nvim-lastplace").setup({
		lastplace_open_folds = true,
	})
end

return M
