local M = {}

M.config = function()
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
	vim.wo.foldlevel = 3
	vim.wo.foldminlines = 1
	vim.wo.foldnestmax = 3
	vim.wo.foldtext =
		[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

	lvim.builtin.treesitter.matchup.enable = true
	lvim.builtin.treesitter.textobjects.select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["al"] = "@call.outer",
			["il"] = "@call.inner",
			["ad"] = "@conditional.outer",
			["id"] = "@conditional.inner",
		},
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
	}
	lvim.builtin.treesitter.textobjects.move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
			["]f"] = "@function.outer",
			["]]"] = "@class.outer",
			["]a"] = "@parameter.outer",
		},
		goto_next_end = {
			["]F"] = "@function.outer",
			["]["] = "@class.outer",
			["]A"] = "@parameter.outer",
		},
		goto_previous_start = {
			["[f"] = "@function.outer",
			["[["] = "@class.outer",
			["[a"] = "@parameter.outer",
		},
		goto_previous_end = {
			["[F"] = "@function.outer",
			["[]"] = "@class.outer",
			["[A"] = "@parameter.outer",
		},
	}
	lvim.builtin.treesitter.textobjects.swap = {
		enable = true,
		swap_next = {
			["<M-a>"] = "@parameter.inner",
		},
		swap_previous = {
			["<M-A>"] = "@parameter.inner",
		},
	}
	lvim.builtin.treesitter.autotag.enable = true
	lvim.builtin.treesitter.rainbow.enable = true
	lvim.builtin.treesitter.ensure_installed = {
		"bash",
		"vim",
		"lua",
		"c",
		"make",
		"cpp",
		"cmake",
		"go",
		"gomod",
		"python",
		"javascript",
		"typescript",
		"tsx",
		"http",
		"html",
		"css",
		"markdown",
		"json",
		"jsonc",
		"yaml",
		"toml",
		"comment",
		"regex",
		"rust",
		"dockerfile",
	}
end

return M
