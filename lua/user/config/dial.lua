local M = {}

M.config = function()
	local augend = require("dial.augend")
	require("dial.config").augends:register_group({
		default = {
      augend.integer.alias.decimal,
			augend.date.alias["%Y/%m/%d"],
			augend.date.alias["%Y年%-m月%-d日"],
			augend.constant.alias.bool,
			augend.constant.new({ elements = { "True", "False" } }), -- for python
			augend.constant.new({ elements = { "and", "or" } }), -- for python
      augend.constant.new({ elements = { "&&", "||" } }),
		},
	})
  -- 1
	-- ("2020年12月31日")
	vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
	vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
	vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
	vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
	vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
	vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
end

return M
