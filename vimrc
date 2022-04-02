" Personal vim configuration of Sebastian Albert
" with a couple of relicts from Learn[ing] Vimscript the Hard Way:
" https://learnvimscriptthehardway.stevelosh.com/

:set shiftround
:set number
:filetype plugin indent on

:inoremap <Leader>u <Esc>gUawea
:nnoremap <Leader>.e :vsp $MYVIMRC<CR>
:nnoremap <Leader>.s :source $MYVIMRC<CR>
:inoremap jk <Esc>
:nnoremap <Leader>; :cprevious<CR>
:nnoremap <Leader>' :cnext<CR>
:nnoremap <Leader>: :cfirst<CR>
:nnoremap <Leader>" :clast<CR>


highlight LineNr ctermbg=LightCyan ctermfg=black
highlight Folded cterm=bold ctermbg=White ctermfg=DarkGrey

" Highlight trailing whitespace and characters beyond column 79 {{{

function s:GeneralHighlights()

	highlight longer_than_79 ctermbg=lightred guibg=#ff9999
	:let w:mll = matchadd("longer_than_79", '\%>79v.\+')

	highlight bad_whitespace ctermbg=red
	:let w:mbw = matchadd("bad_whitespace", '\s\+$\| \+\ze\t')

endfunction

function s:GeneralHighlightsAllWindows()
	for wi in getwininfo()
		call win_execute(wi.winid, 'call s:GeneralHighlights()')
	endfor
endfunction

augroup highlights
autocmd!
autocmd WinNew * call s:GeneralHighlights()
autocmd VimEnter * call s:GeneralHighlightsAllWindows()
augroup END

" }}}

" Vimscript file settings {{{
augroup filetype_vim
autocmd!
autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Haskell file settings {{{
augroup filetype_haskell
autocmd!
autocmd FileType haskell setlocal et
augroup END
" }}}

" operator pending mappings {{{
onoremap in( :<C-u>normal! f(vi(<CR>
onoremap il( :<C-u>normal! F)vi(<CR>
onoremap an( :<C-u>normal! f(va(<CR>
onoremap al( :<C-u>normal! F)va(<CR>
onoremap in{ :<C-u>normal! f{vi{<CR>
onoremap il{ :<C-u>normal! F}vi{<CR>
onoremap an{ :<C-u>normal! f{va{<CR>
onoremap al{ :<C-u>normal! F}va{<CR>
onoremap in[ :<C-u>normal! f[vi[<CR>
onoremap il[ :<C-u>normal! F]vi[<CR>
onoremap an[ :<C-u>normal! f[va[<CR>
onoremap al[ :<C-u>normal! F]va[<CR>
" }}}

nnoremap <Leader>c :call <SID>QuickfixToggle()<CR>

function! s:QuickfixToggle()
	copen
endfunction
