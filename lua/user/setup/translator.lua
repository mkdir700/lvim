local M = {}

M.setup = function()
	vim.g.translator_default_engines = { "google", "youdao" }
end

return M
