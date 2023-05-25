local M = {}

M.setup = function()
	vim.cmd([[
    " VM will override <BS>
    function! VM_Start()
      iunmap <buffer><Bs>
    endf
    function! VM_Exit()
      exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.bufnr().')'
    endf
    let g:VM_theme = "neon"
  ]])
end

return M
