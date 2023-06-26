M = {}

M.config = function()
	require("flatten").setup({
		window = {
			-- Options:
			-- current        -> open in current window (default)
			-- alternate      -> open in alternate window (recommended)
			-- tab            -> open in new tab
			-- split          -> open in split
			-- vsplit         -> open in vsplit
			-- func(new_file_names, argv, stdin_buf_id) -> only open the files, allowing you to handle window opening yourself.
			-- The first argument is an array of file names representing the newly opened files.
			-- The third argument is only provided when a buffer is created from stdin.
			-- IMPORTANT: For `block_for` to work, you need to return a buffer number.
			--            The `filetype` of this buffer will determine whether block should happen or not.
			open = "alternate",
			-- Affects which file gets focused when opening multiple at once
			-- Options:
			-- "first"        -> open first file of new files (default)
			-- "last"         -> open last file of new files
			focus = "first",
		},
	})
end

return M
