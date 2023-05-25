local M = {}

M.config = function()
	require("im_select").setup({

		-- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
		-- For Windows/WSL, default: "1033", aka: English US Keyboard
		-- For macOS, default: "com.apple.keylayout.ABC", aka: US
		-- You can use `im-select` in cli to get the IM's name you preferred
		default_im_select = "com.apple.keylayout.ABC",

		-- Set to 1 if you don't want restore IM status when `InsertEnter`
		set_previous_events = 1,

		-- Can be binary's name or binary's full path,
		-- e.g. 'im-select' or '/usr/local/bin/im-select'
		-- For Windows/WSL, default: "im-select.exe"
		-- For macOS, default: "im-select"
		default_command = "im-select",
	})
end

return M
