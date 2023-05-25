local M = {}

M.config = function()
	require("neotest").setup({
		adapters = {
			require("neotest-python")({
				-- Extra arguments for nvim-dap configuration
				-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
				dap = { justMyCode = false },
				-- Command line arguments for runner
				-- Can also be a function to return dynamic values
				args = { "--log-level", "DEBUG" },
				-- Runner to use. Will use pytest if available by default.
				-- Can be a function to return dynamic value.
				runner = "unittest",
				-- Custom python path for the runner.
				-- Can be a string or a list of strings.
				-- Can also be a function to return dynamic value.
				-- If not provided, the path will be inferred by checking for
				-- virtual envs in the local directory and for Pipenev/Poetry configs
        -- FIXME: 如何设置为当前项目的虚拟环境？
				python = "/home/xyz/.virtualenvs/xyz-logistics-hmi-back/bin/python",
				-- Returns if a given file path is a test file.
				-- NB: This function is called a lot so don't perform any heavy tasks within it.
				-- is_test_file = function(file_path)
				--   ...
				-- end,
			}),
		},
	})

	lvim.builtin.which_key.mappings.t = {
		name = "Run Tests",
		t = { "<CMD>lua require('neotest').run.run()<CR>", "运行当前测试用例" },
		d = { "<CMD>lua require('neotest').run.run({strategy = 'dap'})<CR>", "运行当前测试用例(DEBUG)" },
    l = { "<CMD>lua require('neotest').run.run_last()<CR>", "运行最近测试用例" },
    L = { "<CMD>lua require('neotest').run.run_last({strategy = 'dap'})<CR>", "运行最近测试用例(DEBUG)" },
		f = { "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "运行当前文件" },
		s = { "<CMD>lua require('neotest').summary.toggle()<CR>", "查看测试概要" },
		S = { "<CMD>lua require('neotest').run.stop()<CR>", "停止" },
    o = { "<CMD>lua require('neotest').output.open()<CR>", "查看输出" },
    p = { "<CMD>lua require('neotest').output_panel.toggle()<CR>", "输出面板" }
	}
end

return M
