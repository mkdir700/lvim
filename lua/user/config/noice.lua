local M = {}

M.config = function()
	require("noice").setup({
		cmdline = {
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = "🔍", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = "🔍", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = {}, -- Used by input()
			},
		},
		messages = {
			enabled = false, -- enables the Noice messages UI
			view = "mini", -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify", -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
		},
		lsp = {
			progress = {
				enabled = true,
				format = "lsp_progress",
				format_done = "lsp_progress_done",
				throttle = 1000 / 30, -- frequency to update lsp progress message
				view = "merged_notify",
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			-- WARN: 冲突 textDocument/signatureHelp
			signature = {
				enabled = false,
			},
			hover = {
				enabled = false,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		views = {
			merged_notify = {
				backend = "notify",
				fallback = "mini",
				format = "notify",
				replace = true,
				merge = true,
			},
			cmdline = {
				backend = "popup",
				relative = "editor",
				position = {
					row = "100%",
					col = 0,
				},
				size = {
					height = "auto",
					width = "100%",
				},
				border = {
					style = "none",
				},
				win_options = {
					winhighlight = {
						Normal = "NoiceCmdline",
						IncSearch = "",
						Search = "",
					},
				},
			},
		},
		routes = {
			-- show macro recording
			{
				view = "notify",
				filter = { event = "msg_showmode" },
			},
		},
	})

	-- TODO: 计划替换为 <C-d>/<C-u> 但是不知道怎么实现
	-- 这里替换之后，会发生冲突
	-- vim.keymap.set("n", "<C-d>", function()
	-- 	if not require("noice.lsp").scroll(4) then
	-- 		return "<C-d>"
	-- 	end
	-- end, { silent = true, expr = true })
	-- vim.keymap.set("n", "<C-u>", function()
	-- 	if not require("noice.lsp").scroll(-4) then
	-- 		return "<C-u>"
	-- 	end
	-- end, { silent = true, expr = true })

	require("notify").setup({
		timeout = 1000,
		icons = {
			ERROR = " ",
			WARN = " ",
			INFO = " ",
			DEBUG = " ",
			TRACE = " ",
		},
		background_colour = "#ccc",
	})
end

return M
