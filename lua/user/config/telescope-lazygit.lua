local M = {}

M.config = function()
  require("telescope").load_extension("lazygit")
  lvim.builtin.which_key.mappings.g.g = {
    "<CMD>LazyGit<CR>",
    "LazyGit",
  }
end

return M
