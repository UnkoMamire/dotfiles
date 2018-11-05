" インデント設定
set cinoptions+=:0,g0

" C/C++ insert UUID based include guard
function! s:insert_include_guard()
	let s:uuid=system('uuidgen')
	let s:uuid=strpart(s:uuid, 0, strlen(s:uuid)-1)
	let s:uuid=substitute(s:uuid, '[a-f]', '\u\0', 'g')
	let s:uuid=substitute(s:uuid, '\-', '_', 'g')
	let s:uuid='INCUDE_GUARD_UUID_'.s:uuid
	call append(0, '#ifndef '.s:uuid)
	call append(1, '#define '.s:uuid)
	call append(2, '')
	call append('$', '#endif //'.s:uuid)
endfunction
command! -nargs=0 IncludeGuard call s:insert_include_guard()

" vim-stargate
function! s:load_stargate()
	if !exists("g:stargate#include_default_format")
		StargateClearCache
	endif
endfunction
function! s:add_inc()
	call s:load_stargate()
	let g:stargate#include_default_format.c = "include_square_parentheses"
	let g:stargate#include_default_format.cpp = "include_square_parentheses"
	return ":StargateInclude "
endfunction
function! s:add_Inc()
	call s:load_stargate()
	let g:stargate#include_default_format.c = "include_double_quotation"
	let g:stargate#include_default_format.cpp = "include_double_quotation"
	return ":StargateInclude "
endfunction
nnoremap <buffer><expr> <Leader>i <SID>add_inc() 
nnoremap <buffer><expr> <Leader>I <SID>add_Inc() 

" インクルードを取り消し
nnoremap <buffer> <Leader>o :StargateOutclude 
command! -nargs=1 StargateOutclude glob/\v\#include\s*[\<\"]<args>/delete

