local M = {}

-- local function on_attach(_, bufnr)
-- 	require("rust-tools").inlay_hints.set()
-- 	require("rust-tools").inlay_hints.enable()
-- 	local bufopts = { silent = true, noremap = true, buffer = bufnr }
-- 	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
-- 	vim.keymap.set("n", "K", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
-- 	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
-- 	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
-- 	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
-- 	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
-- 	-- lvim.keys.normal_mode[""] = {}
-- 	-- vim.keymap.set("n", "gl", function()
-- 	-- 	local config = lvim.lsp.diagnostics.float
-- 	-- 	config.scope = "line"
-- 	-- 	vim.diagnostic.open_float(0, config)
-- 	-- end, bufopts)
-- 	--
-- end

M.config = function()
	require("rust-tools").setup({
		tools = {
			runnables = {
				use_telescope = true,
			},
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = true,
				show_variable_name = true,
				parameter_hints_prefix = "<- ",
				other_hints_prefix = "=> ",
			},
		},

		-- all the opts to send to nvim-lspconfig
		-- these override the defaults set by rust-tools.nvim
		-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
		server = {
			-- on_attach is a callback called when the language server attachs to the buffer
			-- on_attach = on_attach,
			on_attach = require("lvim.lsp").common_on_attach,
			on_init = require("lvim.lsp").common_on_init,
			settings = {
				-- to enable rust-analyzer settings visit:
				-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
				["rust-analyzer"] = {
					-- enable clippy on save
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		},
	})
end

return M
