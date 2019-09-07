" インクルードパス補完
let cpp_var_list=split(system('ls /usr/include/c++'),"\n")
let &path='.,/usr/include,/usr/include/c++/'.cpp_var_list[-1].','

" 名前空間の入力を簡単にする
inoremap <buffer><expr>; <SID>expand_namespace()
function! s:expand_namespace()
	if search('b;\%#', 'bcn')
		return "\<BS>oost::"
	elseif search('s;\%#', 'bcn')
		return "\<BS>td::"
	elseif search('d;\%#', 'bcn')
		return "\<BS>etail::"
	elseif search(';;\%#', 'bcn')
		return "\<BS>::"
	else
		return ';'
	endif
endfunction

