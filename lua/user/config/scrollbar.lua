local M = {}

M.config = function()
	require("scrollbar").setup({
		handle = {
			text = " ",
			color = "#303858",
			highlight = "CursorColumn",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
		marks = {
			Search = {
				text = { "⠒", "⠶", "⠿", "⣿" },
				priority = 0,
				color = "#ffd600",
				cterm = nil,
				highlight = "Search",
			},
			Error = {
				text = { "⠒", "⠶", "⠿", "⣿" },
				priority = 1,
				color = "#d50000",
				cterm = nil,
				highlight = "DiagnosticVirtualTextError",
			},
			Warn = {
				text = { "⠒", "⠶", "⠿", "⣿" },
				priority = 2,
				color = "#ff9100",
				cterm = nil,
				highlight = "DiagnosticVirtualTextWarn",
			},
			Info = {
				text = { "⠒", "⠶", "⠿", "⣿" },
				priority = 3,
				color = "#00b0ff",
				cterm = nil,
				highlight = "DiagnosticVirtualTextInfo",
			},
			Hint = {
				text = { "⠒", "⠶", "⠿", "⣿" },
				priority = 4,
				color = "#76ff03",
				cterm = nil,
				highlight = "DiagnosticVirtualTextHint",
			},
			Misc = {
				text = { "⠒", "⠶", "⠿", "⣿" },
				priority = 5,
				color = nil,
				cterm = nil,
				highlight = "Normal",
			},
		},
	})
end

return M
