require("user.neovim").config()

require("user.alpha").config()

-- In order to disable lunarvim's default colorscheme
lvim.colorscheme = "default"
vim.opt.termguicolors = true
vim.o.jumpoptions = "stack"
lvim.builtin.bufferline.options.always_show_bufferline = false
-- 启用拼写检查器和单词补全
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

require("user.statusline").config()

-- lvim.builtin.terminal.shell = "/opt/homebrew/bin/fish"
-- lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.open_mapping = "<M-Space>" -- ctrl+`
lvim.builtin.nvimtree.setup.view.mappings.list = {
	{ key = { "l", "<CR>" }, action = "edit", mode = "n" },
	{ key = "h", action = "close_node" },
	{ key = "v", action = "vsplit" },
}

lvim.lsp.installer.setup.ensure_installed = {
	"sumneko_lua",
	"tsserver",
	"tailwindcss",
	"bashls",
	"cssls",
	"dockerls",
	"emmet_ls",
	"html",
	"jsonls",
	"pyright",
	"rust_analyzer",
	"taplo",
	"yamlls",
	"gopls",
}

----------------------------------------
-- Telescope
----------------------------------------
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<Esc>"] = actions.close,
	},
	-- for normal mode
	n = {},
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = true })

require("user.treesitter").config()

require("user.lsp").config()

require("user.plugins").config()

require("user.keybindings").config()

require("user.config.toggleterm").config()

require("user.telescope").config()
