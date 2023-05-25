local M = {}

M.config = function()
	vim.list_extend(lvim.builtin.cmp.sources, {
		{ name = "lab.quick_data", keyword_length = 4 },
	})
	require("lab").setup({
		code_runner = {
			enabled = true,
		},
		quick_data = {
			enabled = true,
		},
	})
end

return M
