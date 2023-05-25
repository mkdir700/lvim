local M = {}

M.config = function()
	require("syntax-tree-surfer").setup({})

	local opts = { noremap = true, silent = true }

	-- 选择当前节点的兄弟节点/父节点/子节点
	vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
	vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
	vim.keymap.set("x", "P", "<cmd>STSSelectParentNode<cr>", opts)
	vim.keymap.set("x", "N", "<cmd>STSSelectChildNode<cr>", opts)

	-- 交换当前节点和下一个节点
	vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
	vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)
end

return M
