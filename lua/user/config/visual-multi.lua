local M = {}

M.config = function()
	vim.api.nvim_set_keymap("n", "<C-S-L>", "<Plug>(VM-Select-All)", {})
	vim.api.nvim_set_keymap("v", "<C-S-L>", "<Plug>(VM-Visual-All)", {})
	-- TODO:应该设置成仅 visual-multi 模式下生效
	vim.api.nvim_set_keymap("n", "ma", "<Plug>(VM-Add-Cursor-At-Pos)", {})
	vim.api.nvim_set_keymap("v", "ma", "<Plug>(VM-Visual-Add)", {})
	vim.api.nvim_set_keymap("i", "<C-h>", "<BS>", {})
end

return M
