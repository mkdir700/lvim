local M = {}

-- NOTE: 无用
M.config = function()
	require("telescope").load_extension("notify")
	lvim.builtin.which_key.mappings.s.n = {
		"<CMD>Telescope notify<CR>",
		"Notify History",
	}
end

return M
