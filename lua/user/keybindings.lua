local M = {}

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.config = function()
	--------------
	-- 屏幕(screen)滚动 --
	--------------
	-- plugin: neoscroll.nvim
	--------------------
	-- 会话持久化管理 --
	--------------------
	lvim.builtin.which_key.mappings.s.s = {
		":Telescope persisted<CR>",
		"View Sessions",
	}
	lvim.builtin.which_key.mappings["S"] = {
		name = "Session",
		l = { "<CMD>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
		c = { "<CMD>lua require('persistence').load()<cr>", "Restore last session for current dir" },
		q = { "<CMD>lua require('persistence').stop()<cr>", "Quit without saving session" },
		s = { ":Telescope persisted<CR>", "View Sessions" },
	}

	--------------
	-- 窗口(widnows)管理 --
	--------------
	map("n", "<M-}>", ":resize +2<CR>")
	map("n", "<M-{>", ":resize -2<CR>")
	map("n", "<M-]>", ":vertical resize -2<CR>")
	map("n", "<M-[>", ":vertical resize +2<CR>")
	map("n", "_", ":sp<CR>")
	map("n", "|", ":vsp<CR>")
	vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
	-- select window
	vim.keymap.set("n", "<M-w>", function()
		local picker = require("window-picker")
		local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
		vim.api.nvim_set_current_win(picked_window_id)
	end, { desc = "Pick a window" })

	--------------
	-- 光标(cursor)移动 --
	--------------
	-- plugin: clever-f.vim
	-- plugin: hop.nvim
	-- plugin: vim-matchup
	-- plugin: leap.vim
	map("c", "<C-a>", "<C-b>", { noremap = true })
	map("n", ";", "<CMD>HopChar2<CR>", { silent = true })
	map("n", ",", "<CMD>HopLineStartMW<CR>", { silent = true })
	map("i", "<C-f>", "<Right>")
	map("i", "<C-b>", "<Left>")

	--------------
	-- 标签跳转 --
	--------------
	-- plugin: nvim-lastplace
	-- plugin: vim-bookmarks
	-- plugin: telescope-vim-bookmarks
	-- HACK: terminal map: ctrl+i -> alt+shift+i
	map("n", "<C-i>", "<C-i>", { silent = true })
	map("i", "<C-a>", "<C-[>I") -- 编辑状态下，快速移动至头部
	map("i", "<C-e>", "<C-[>A") -- 编辑状态下，快速移动至尾部
	map("n", "mm", "<Plug>BookmarkToggle", { noremap = false })
	map("n", "mi", "<Plug>BookmarkAnnotate", { noremap = false })
	map("n", "mn", "<Plug>BookmarkNext", { noremap = false })
	map("n", "mp", "<Plug>BookmarkPrev", { noremap = false })
	map("n", "mc", "<Plug>BookmarkClear", { noremap = false })
	map("n", "mC", "<Plug>BookmarkClearAll", { noremap = false })
	map("n", "mjj", "<Plug>BookmarkMoveDown", { noremap = false })
	map("n", "mkk", "<Plug>BookmarkMoveUp", { noremap = false })
	map("n", "mg", "<Plug>BookmarkMoveToLine", { noremap = false })
	map("n", "]g", "<CMD>Gitsigns next_hunk<CR>")
	map("n", "[g", "<CMD>Gitsigns prev_hunk<CR>")
	-- 测试用例跳转
	map(
		"n",
		"]n",
		"<CMD>lua require('neotest').jump.next({ status = 'failed' })<CR>",
		{ desc = "Next failed testcase", silent = true }
	)
	map(
		"n",
		"[n",
		"<CMD>lua require('neotest').jump.prev({ status = 'failed' })<CR>",
		{ desc = "Previous failed testcase", silent = true }
	)
	-- Todo 标签跳转
	map("n", "]t", "<CMD>lua require('todo-comments').jump_next()<CR>", { desc = "Next todo comments" })
	map("n", "[t", "<CMD>lua require('todo-comments').jump_prev()<CR>", { desc = "Previous todo comments" })
	-- 缓冲区(buffer)跳转
	map("n", "[b", "<Plug>(CybuPrev)", { desc = "Next buffer", silent = true })
	map("n", "]b", "<Plug>(CybuNext)", { desc = "Previous buffer", silent = true })
	map("n", "[e", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
	map("n", "]e", "<CMD>lua vim.diagnostic.goto_next()<CR>")
	vim.keymap.set({ "n", "v" }, "<M-Tab>", "<plug>(CybuLastusedPrev)")
	vim.keymap.set({ "n", "v" }, "<M-S-Tab>", "<plug>(CybuLastusedNext)")

	--------------
	-- 全文搜索 --
	--------------
	-- plugin: vim-visual-star-search
	-- plugin: vim-cool
	-- plugin: telescope-live-grep-raw.nvim
	-- plugin: nvim-spectre
	map("n", "n", "'Nn'[v:searchforward]", { expr = true })
	map("n", "N", "'nN'[v:searchforward]", { expr = true })
	map("n", "<M-l>", "<CMD>nohl<CR><C-l>")
	map("c", "<M-W>", "\\<\\><Left><Left>")
	map("c", "<M-r>", "\\v")
	map("c", "<M-c>", "\\C")
	map("n", "<C-f>", "<CMD>Telescope current_buffer_fuzzy_find<CR>")
	map("v", "<C-f>", "y<ESC>:Telescope current_buffer_fuzzy_find default_text=<c-r>0<CR>")
	map("n", "<C-s>", "<CMD>Telescope lsp_document_symbols<CR>")
	map("v", "<C-s>", "y<ESC>:Telescope lsp_document_symbols default_text=<c-r>0<CR>")
	map("n", "<C-t>", "<CMD>Telescope lsp_workspace_symbols<CR>")
	map("v", "<C-t>", "y<ESC>:Telescope lsp_workspace_symbols default_text=<c-r>0<CR>")
	lvim.builtin.which_key.vmappings.s = {
		name = "Search",
		f = { "y<ESC>:Telescope find_files default_text=<c-r>0<CR>", "Find File" },
		h = { "y<ESC>:Telescope help_tags default_text=<c-r>0<CR>", "Find Help" },
		R = { "y<ESC>:Telescope registers default_text=<c-r>0<CR>", "Registers" },
		t = { "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", "Text" },
		k = { "y<ESC>:Telescope keymaps default_text=<c-r>0<CR>", "Keymaps" },
		C = { "y<ESC>:Telescope commands default_text=<c-r>0<CR>", "Commands" },
	}

	--------------
	-- 快速编辑(Edit) --
	--------------
	-- plugin: vim-visual-multi
	map("i", "jk", "<C-[>")
	map("n", ">", ">>")
	map("n", "<", "<<")
	map("i", "<C-S-J>", "<CMD>m .+1<CR><Cmd>normal ==<CR>")
	map("n", "<C-S-J>", "<CMD>m .+1<CR><Cmd>normal ==<CR>")
	map("i", "<C-S-K>", "<CMD>m .-2<CR><Cmd>normal ==<CR>")
	map("n", "<C-S-K>", "<CMD>m .-2<CR><Cmd>normal ==<CR>")
	map("c", "<C-f>", "<Right>")
	map("c", "<C-b>", "<Left>")
	map("v", "L", "$")
	map("v", "H", "^")
	map("o", "L", "$")
	map("o", "H", "^")
	-- 输入模式下 Shift + Enter 在当前行下面插入新行
	map("i", "<S-Enter>", "<Esc>o")

	--------------
	-- 普通模式 --
	--------------
	-- plugin: vim-expand-region
	-- plugin: vim-textobj-user
	-- plugin: vim-textobj-entire
	-- plugin: vim-textobj-indent
	-- plugin: vim-textobj-line
	-- plugin: vim-textobj-parameter
	-- plugin: nvim-treesitter-textobjects
	-- plugin: vim-repeate
	-- plugin: vim-surround
	-- map("n", "S", "i<CR><Esc>")

	--------------
	-- 复制粘贴 --
	----------------
	-- 复制后，光标的位置不会改变
	vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
	vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
	vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
	-- 剪切(粘贴后复制, 原版 vim 的操作逻辑)
	-- vim.keymap.set({ "n", "x" }, "=p", "<Plug>(YankyGPutAfter)")
	-- vim.keymap.set({ "n", "x" }, "=P", "<Plug>(YankyGPutBefore)")
	-- 这将强制在当前行上方或下方放置
	map("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
	map("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
	-- 在当前行的上行/下行粘贴，并重新缩进
	map("n", "=p", "<Plug>(YankyPutAfterFilter)")
	map("n", "=P", "<Plug>(YankyPutBeforeFilter)")
	-- 循环选择剪切版
	vim.keymap.set("n", "<M-n>", "<Plug>(YankyCycleForward)")
	vim.keymap.set("n", "<M-p>", "<Plug>(YankyCycleBackward)")
	map("i", "<C-v>", "<C-r>+")
	map("n", "Y", "y$")
	lvim.builtin.which_key.mappings["o"] = { "<CMD>put =@+<CR>", "Paste Clipboard to Next Line" }
	lvim.builtin.which_key.mappings["O"] = { "<CMD>put! =@+<CR>", "Paste Clipboard to Previous Line" }
	lvim.builtin.which_key.mappings["by"] = { "<CMD>%y +<CR>", "Yank Whole Buffer to Clipboard" }
	lvim.builtin.which_key.mappings["bp"] = { '<CMD>%d<CR>"+P', "Patse Clipboard to Whole Buffer" }

	--------------
	-- 语言服务 --
	--------------
	-- plugin: fidget.nvim
	-- plugin: lsp_signature.nvim
	-- plugin: telescope-luasnip.nvim
	-- plugin: clangd_extensions.nvim
	-- plugin: nvim-ts-qutotag
	lvim.builtin.cmp.confirm_opts.select = true
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lccm = require("lvim.core.cmp").methods

	-- 检查当前光标的后一位是否是 pair
	-- @return bool
	local function is_next_char_pair()
		local line = vim.api.nvim_get_current_line()
		local _, col = unpack(vim.api.nvim_win_get_cursor(0))
		local after = line:sub(col + 1, -1)
		local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
		for _, pair in ipairs(closers) do
			if after:sub(1, #pair) == pair then
				return true
			end
		end
		return false
	end

	-- 跳出 pair
	local function escape_pair()
		local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
		local line = vim.api.nvim_get_current_line()
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local after = line:sub(col + 1, -1)
		local closer_col = #after + 1
		local closer_i = nil
		for i, closer in ipairs(closers) do
			local cur_index, _ = after:find(closer)
			if cur_index and (cur_index < closer_col) then
				closer_col = cur_index
				closer_i = i
			end
		end
		if closer_i then
			vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
		else
			vim.api.nvim_win_set_cursor(0, { row, col + 1 })
		end
	end

	lvim.builtin.cmp.mapping = cmp.mapping.preset.insert({
		["<C-f>"] = nil,
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-y>"] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
		}),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm(lvim.builtin.cmp.confirm_opts)
			else
				fallback()
			end
		end),
		["<Tab>"] = cmp.mapping(function(fallback)
			if is_next_char_pair() then
				escape_pair()
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif lccm.jumpable(1) then
				luasnip.jump(1)
			elseif lccm.has_words_before() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-e>"] = cmp.mapping.abort(),
	})

	map("n", "<M-F>", '<CMD>lua require("lvim.lsp.utils").format({timeout_ms= 2000})<CR>')
	map("i", "<M-F>", '<CMD>lua require("lvim.lsp.utils").format({timeout_ms= 2000})<CR>')
	map("n", "<F2>", "<CMD>lua vim.lsp.buf.rename()<CR>")
	-- 给出代码建议
	map("n", "<M-.>", "<CMD>lua vim.lsp.buf.code_action()<CR>")
	-- 代码注释
	map("n", "<C-_>", "gccj", { noremap = false })
	map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { noremap = false })
	map("i", "<C-_>", "<CMD>normal gcc<CR>")
	-- 使用 Trouble 插件展示引用信息
	map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
	-- 为函数添加注释
	lvim.builtin.which_key.mappings.l.g = { "<CMD>Neogen func<CR>", "Func Doc" }
	-- 为类添加注释
	lvim.builtin.which_key.mappings.l.G = { "<CMD>Neogen class<CR>", "Class Doc" }
	-- lvim.builtin.which_key.mappings.l.x = { "<cmd>TroubleToggle<cr>", "Trouble", { silent = true, noremap = true } }
	-- 展示当前文件的问题
	lvim.builtin.which_key.mappings.l.x =
		{ "<cmd>TroubleToggle document_diagnostics<cr>", "Document Trouble", { silent = true, noremap = true } }
	-- 展示当前工作区的问题
	lvim.builtin.which_key.mappings.l.X =
		{ "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Trouble", { silent = true, noremap = true } }
	-- vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
	--   {silent = true, noremap = true}
	-- )
	-- vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
	--   {silent = true, noremap = true}
	-- )
	-- 重启 LSP
	lvim.builtin.which_key.mappings.l.R = { "<cmd>LspRestart<cr>", "Restart LSP", { silent = true, noremap = true } }

	--------------
	-- 文件(File)操作 --
	--------------
	-- plugin: suda.vim
	-- plugin: persistence.nvim
	-- lvim.keys.normal_mode["<C-k>"] = false
	map("n", "<Tab>", "<CMD>wincmd w<CR>")
	map("n", "<S-Tab>", "<CMD>wincmd p<CR>")
	lvim.builtin.which_key.mappings["k"] = {
		name = "File",
		n = { "<CMD>enew<CR>", "新建文件" },
		o = { "<CMD>Telescope oldfiles<CR>", "老(最近)文件" },
		f = { "<CMD>Telescope find_files<CR>", "查找当前目录下的文件" },
		r = { ":e <C-r>=fnamemodify(expand('%:p'), ':p:h')<CR>/", "重命名文件" },
		p = { "<CMD>Telescope projects<CR>", "最近打开的项目" },
		s = {
			name = "保存",
			s = { "<CMD>SudaWrite<CR>", "超级权限写" },
			a = { "<CMD>wa<CR>", "保存全部文件" },
			o = { ":saveas <C-r>=fnamemodify('.',':p')<CR>", "另存为" },
		},
		-- u = { ":try | %bd | catch | endtry<CR>", "try" }
	}
	lvim.builtin.which_key.mappings["q"] = { "<CMD>call SmartClose()<CR>", "Quit" }
	lvim.builtin.which_key.mappings["Q"] = { "<CMD>qa<CR>", "Close VIM" }

	--------------
	-- 界面元素 --
	--------------
	-- plugin: dressing.nvim
	-- plugin: nvim-scrollbar
	-- plugin: sidebar.nvim
	-- plugin: symbols-outline.nvim
	-- plugin: todo-comments.nvim
	-- plugin: undotree
	-- plugin: trouble.nvim
	-- plugin: nvim-bqf
	-- map("n", "<C-M-E>", "<CMD>NvimTreeFindFile<CR>")
	-- map("n", "<C-S-U>", "<CMD>lua require('telescope').extensions.notify.notify()<CR>")
	lvim.builtin.which_key.mappings["a"] = {
		name = "Application",
		o = { "<CMD>SymbolsOutline<CR>", "Outline" },
		t = { "<CMD>TodoTrouble<CR>", "TODO" },
		u = { "<CMD>UndotreeToggle<CR>", "UndoTree" },
		C = { "<CMD>Calc<CR>", "Calculator" },
		i = { "<CMD>Autoflake --remove-all-unused-imports<CR>", "AutoFlake" },
		c = { "<CMD>ChatGPT<CR>", "ChatGPT" },
		d = { "<CMD>DiffviewOpen<CR>", "Diffview" },
		g = { "<CMD>Glow<CR>", "Render Markdown" },
	}
	lvim.builtin.which_key.vmappings.a = {
		name = "Application",
	}

	--------------
	-- LSP 按键 --
	--------------
	-- 对 lunarvim 的 lsp 按键的补充
	map("n", "gt", ":lua vim.lsp.buf.type_definition()<cr>", { desc = "Goto Type Definition" })

	--------------
	-- 其他按键 --
	--------------
	-- map("n", "<C-k><C-s>", "<CMD>Telescope keymaps<CR>")
	map("n", "<M-z>", "<CMD>let &wrap=!&wrap<CR>")
	map("n", "<M-t>", "<CMD>TranslateW<CR>")
	map("v", "<M-t>", ":TranslateW<CR>")
	map("n", "<M-e>", "<CMD>NvimTreeFocus<CR>")
	map("n", "<C-S-P>", "<CMD>Telescope commands<CR>")
	lvim.builtin.which_key.mappings[";"] = nil
	lvim.builtin.which_key.mappings["/"] = nil
	lvim.builtin.which_key.mappings["h"] = nil
	lvim.builtin.which_key.mappings["e"] = nil -- FIXME: 没有效果

	--------------
	-- 缓冲区按键 --
	--------------
	lvim.builtin.which_key.mappings.b.o = {
		"<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
		"Close all but current",
	}

	vim.cmd([[
function! SmartClose() abort
  if &bt ==# 'nofile' || &bt ==# 'quickfix'
    quit
    return
  endif
  let num = winnr('$')
  for i in range(1, num)
    let buftype = getbufvar(winbufnr(i), '&buftype')
    if buftype ==# 'quickfix' || buftype ==# 'nofile'
      let num = num - 1
    elseif getwinvar(i, '&previewwindow') == 1 && winnr() !=# i
      let num = num - 1
    endif
  endfor
  if num == 1
    if len(getbufinfo({'buflisted':1,'bufloaded':1,'bufmodified':1})) > 0
      echohl WarningMsg
      echon 'There are some buffer modified! Quit/Save/Cancel'
      let rs = nr2char(getchar())
      echohl None
      if rs ==? 'q'
        qall!
      elseif rs ==? 's' || rs ==? 'w'
        redraw
        wall
        qall
      else
        redraw
        echohl ModeMsg
        echon 'canceled!'
        echohl None
      endif
    else
      qall
    endif
  else
    quit
  endif
endf

function! Open_file_in_explorer() abort
  if has('win32') || has('wsl')
    call jobstart('explorer.exe .')
  elseif has('unix')
    call jobstart('xdg-open .')
  endif
endf
]])
end

function M.zoom_current_window()
	local cur_win = vim.api.nvim_get_current_win()
	vim.api.nvim_set_var("non_float_total", 0)
	vim.cmd("windo if &buftype != 'nofile' | let g:non_float_total += 1 | endif")
	vim.api.nvim_set_current_win(cur_win or 0)
	if vim.api.nvim_get_var("non_float_total") == 1 then
		if vim.fn.tabpagenr("$") == 1 then
			return
		end
		vim.cmd("tabclose")
	else
		local last_cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd("tabedit %:p")
		vim.api.nvim_win_set_cursor(0, last_cursor)
	end
end

return M
