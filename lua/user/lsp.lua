local M = {}

M.config = function()
	-- 用于 Python 虚拟环境
	require("neoconf").setup()
	require("venom").setup()

	-- ---WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
	-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
	require("lvim.lsp.null-ls.linters").setup({
		{ filetypes = { "sh" }, command = "shellcheck" },
		{ filetypes = { "go" }, command = "golangci_lint" },
		-- { filetypes = { "python" }, command = "mypy", args = { "--ignore-missing-imports" } },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "eslint" },
		{ filetypes = { "html" }, command = "tidy" },
		{ filetypes = { "css" }, command = "stylelint" },
		{ filetypes = { "markdown" }, command = "markdownlint", args = { "--disable", "MD013" } },
		-- { filetype = { "rust" }, command = "cargo", args = { "clippy", "--message-format=json" } },
	})

	lvim.format_on_save = { pattern = "*", timeout = 2000 }
	require("lvim.lsp.null-ls.formatters").setup({
		{ filetypes = { "sh" }, command = "shfmt", extra_args = { "-i", "2" } },
		{ filetypes = { "cmake" }, command = "cmake_format" },
		{ filetype = { "cpp", "c", "objc", "objcpp" }, command = "clang-format" },
		{ filetypes = { "go" }, command = "gofumpt" },
		{ filetypes = { "python" }, command = "isort" },
		{ filetypes = { "python" }, command = "black", extra_args = { "--preview" } },
		{ filetypes = { "lua" }, command = "stylua" },
		{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "prettier" },
		{ filetypes = { "html", "css", "markdown" }, command = "prettier" },
	})

	-- 重新定义 lsp 的默认配置
	local common_on_attach = require("lvim.lsp").common_on_attach
	require("lvim.lsp").common_on_attach = function(client, bufnr)
		require("lsp_signature").on_attach({
			doc_lines = 10,
			floating_window = false,
			floating_window_above_cur_line = false,
			hint_enable = true,
			hint_prefix = "🦉: ",
			extra_trigger_chars = { "(", ",", "=" }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
			zindex = 1002, -- by default it will be on top of all floating windows, set to 50 send it to bottom
			toggle_key = "<C-k>",
			hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
			shadow_guibg = "Green", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
		})
		common_on_attach(client, bufnr)
	end

	local lspconfig = require("lspconfig")

	-- Configure `pyright` for python
	local python_root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"Pipfile",
		"pyrightconfig.json",
		".git",
		".mypy_cache",
		".venv",
		"venv",
	}

	lspconfig["pyright"].setup({
		on_attach = function(client, bufnr)
			common_on_attach(client, bufnr)
			-- 禁用 pyright 的 document_formatting，使用 null-ls 的 document_formatting
			client.server_capabilities.document_formatting = false
			-- 禁用 pyright 的 hoverProvider，使用 ruff-lsp 的 hoverProvider
			-- client.server_capabilities.hoverProvider = false
		end,
		root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
		filetypes = { "python", "py" },
	})

	lspconfig["ruff_lsp"].setup({
		on_attach = common_on_attach,
		root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
		filetypes = { "python", "py" },
	})

	-- 重写 lvim.lsp 的默认配置
	-- lvim.lsp.diagnostics.float.focusable = true

	-- 解决 cpp offsetEncoding 编码警告问题
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
	lspconfig["clangd"].setup({
		on_attach = common_on_attach,
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp", "cc", "h" },
	})

	-- lua LSP
	lspconfig["lua_ls"].setup({
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					special = {
						reload = "require",
					},
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "lvim", "packer_plugins", "reload" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
					maxPreload = 9999,
					preloadFileSize = 10000,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

return M
