function! s:MapQuotes(q)
	execute "nnoremap <Leader>s" . a:q[0] . " "
	\ . ":call <SID>SetQuotes(\"" . a:q->escape("\"") . "\")<CR>"
	\ . ":set operatorfunc=<SID>QuoteOperator<CR>g@"
	execute "vnoremap <Leader>s" . a:q[0] . " "
	\ . ":<C-U>call <SID>SetQuotes(\"" . a:q->escape("\"") . "\")<CR>"
	\ . ":<C-U>call <SID>QuoteOperator(visualmode())<CR>"
endfunction

call s:MapQuotes("''")
call s:MapQuotes("\"\"")
call s:MapQuotes("()")
call s:MapQuotes("[]")
call s:MapQuotes("{}")

let s:quotes = "__"

function! s:SetQuotes(q)
	let s:quotes = a:q
endfunction

function! s:QuoteOperator(type)
	let saved_unnamed_register = @@
	let sel_save = &selection
	let &selection = "old"
	let paste_save = &paste
	let &paste = 1

	if a:type ==# 'v'
		execute "normal! `<v`>"
	elseif a:type ==# 'char'
		execute "normal! `[v`]"
	elseif a:type ==# 'V'
		let pos1 = getpos("'<")
		let pos2 = getpos("'>")
	elseif a:type ==# 'line'
		let pos1 = getpos("'[")
		let pos2 = getpos("']")
	else
		let &paste = paste_save
		let &selection = sel_save
		return
	endif

	if a:type ==# 'v' || a:type ==# 'char'
		execute "normal! c" . s:quotes[0] . "\<C-r>\"" . s:quotes[1]
		\ . "\<Esc>"
	elseif a:type ==# 'line' || a:type ==# 'V'
		call setpos('.', pos2)
		execute "normal! $a" . s:quotes[1] . "\<Esc>"
		call setpos('.', pos1)
		execute "normal! ^i" . s:quotes[0] . "\<Esc>"
	endif

	let &paste = paste_save
	let &selection = sel_save
	let @@ = saved_unnamed_register
endfunction
