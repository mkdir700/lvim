local M = {}

M.config = function()
	lvim.builtin.alpha.active = true
	lvim.builtin.alpha.mode = "dashboard"
	lvim.builtin.alpha.dashboard.section.header = {
		type = "text",
		val = lvim.builtin.alpha.banner,
		opts = {
			position = "center",
			hl = "Comment",
		},
	}
	local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
	if status_ok then
		local function button(sc, txt, keybind, keybind_opts)
			local b = dashboard.button(sc, txt, keybind, keybind_opts)
			b.opts.hl_shortcut = "Macro"
			return b
		end
		table.insert(
			lvim.builtin.alpha.dashboard.section.buttons.val,
			0,
			button("l", "  Restore Session", "<CMD>lua require('persistence').load({ last = true })<CR>")
		)
	end
end

return M
