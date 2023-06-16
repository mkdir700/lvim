local M = {}

M.config = function()
	require("neoai").setup({
		inject = {
			cutoff_width = 2000,
		},
    models = {
      {
        name = "openai",
        model = "gpt-3.5-turbo-16k",
        params = nil,
      }
    },
		shortcuts = {
			{
				name = "textify",
				key = "<leader>as",
				desc = "fix text with AI",
				use_context = true,
				prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
				modes = { "v" },
				strip_function = nil,
			},
			{
				name = "explain",
				key = "<leader>ac",
				desc = "explain selected text/code",
				use_context = true,
				prompt = [[
        请你解释这段代码的作用。
        注意，你现在工作在一个代码编辑器中，所以你需要根据当前上下文猜测这段文本的编程语言，并以对应语言的注释形式输出。
        比如，如果你猜测这段代码是python，那么你应该以 “# 这是一段解释” 的形式输出。
      ]],
				modes = { "v" },
				strip_function = nil,
			},
			{
				name = "translate",
				desc = "translate selected text to english",
				use_context = true,
				prompt = [[
        请将这段文本翻译成英文, 不要输出与翻译内容无关的内容, 仅输出翻译结果, 不要输出引号。
        注意，你现在工作在一个代码编辑器中，所以你需要根据当前上下文猜测这段文本的编程语言，并以对应语言的注释形式输出。
        比如，如果你猜测这段文本是python，原文是 “# 这是一段文本”，那么你应该以 “# This is a text” 的形式输出。
      ]],
				modes = { "v" },
				strip_function = nil,
			},
			{
				name = "gitcommit",
				key = "<leader>aG",
				desc = "generate git commit message",
				use_context = false,
				prompt = function()
					return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff")
				end,
				modes = { "n" },
				strip_function = nil,
			},
		},
	})
end

return M
