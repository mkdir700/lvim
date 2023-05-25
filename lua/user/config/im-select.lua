local M = {}

M.config = function()
	local function im_select()
		-- 判断当前系统
		local os = vim.loop.os_uname().sysname
		if os == "Darwin" then
			return "com.apple.keylayout.ABC"
		elseif os == "Linux" then
			return "1033"
		elseif os == "Windows" then
			return "1033"
		end
	end

	local function command()
		local os = vim.loop.os_uname().sysname
		if os == "Darwin" then
			return "im-select"
		elseif os == "Linux" then
			return "im-select"
		elseif os == "Windows" then
			return "im-select.exe"
		end
	end

	require("im_select").setup({

		-- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
		-- For Windows/WSL, default: "1033", aka: English US Keyboard
		-- For macOS, default: "com.apple.keylayout.ABC", aka: US
		-- You can use `im-select` in cli to get the IM's name you preferred
		default_im_select = im_select(),

		-- Set to 1 if you don't want restore IM status when `InsertEnter`
		set_previous_events = 1,

		-- Can be binary's name or binary's full path,
		-- e.g. 'im-select' or '/usr/local/bin/im-select'
		-- For Windows/WSL, default: "im-select.exe"
		-- For macOS, default: "im-select"
		default_command = command(),
	})
end

return M
