"--------------------------------------------------------------------------
" ターミナル

command! -nargs=* T :call MakeTerm()
tnoremap <c-t><c-t> <C-¥><C-n><C-w><C-w>


"--------------------------------------------------------------------------
" 自動コンパイル
"autocmd nnoremap <expr> <F5> 'aa<CR>'
"autocmd nnoremap <expr> <F5> ':call TermRunnerRun()<CR>'
"autocmd nnoremap <expr> <F6> ':call TermRunnerCmp()<CR>'
"autocmd nnoremap <expr> <F7> ':call TermRunnerEx()<CR>'
"autocmd BufEnter *.py nnoremap <expr> <F5> '<C-w>jipython3 ' . expand("%:p") . '<CR>'

function! MakeTerm() abort
	split
	wincmd j
	resize 12
	terminal
	call feedkeys('i')
endfunction

if has('vim_starting')
	nnoremap <expr> <F5> ':call TermRunnerRun()<CR>'
	nnoremap <expr> <F6> ':call TermRunnerCmp()<CR>'
	nnoremap <expr> <F7> ':call TermRunnerEx()<CR>'
  	let s:ext = expand("%:e")
  	if s:ext == "cpp"
  		let s:cmp = 'g++ -O0 -o ' . expand("%:r") . '.out ' . expand("%:p")
		let s:ex = './' . expand("%:r") . '.out'
  	elseif s:ext == "c"
  		let s:cmp = 'gcc -O0 -o ' . expand("%:r") . '.out ' . expand("%:p")
		let s:ex = './' . expand("%:r") . '.out'
  	elseif s:ext == "java"
  		let s:cmp = 'javac ' . expand("%:p")
		let s:ex = 'java ' . expand("%:r")
  	elseif s:ext == "go"
  		let s:cmp = 'go build ' . expand("%:p")
		let s:ex = './' . expand("%:r")
  	elseif s:ext == "py"
  		let s:cmp = ''
		let s:ex = 'python ' . expand("%:p")
  	endif
endif

function! TermRunnerCmp() abort
	call MakeTerm()
	call feedkeys(s:cmp . "\<CR>", 'n')
endfunction
function! TermRunnerEx() abort
	call MakeTerm()
	call feedkeys(s:ex . "\<CR>", 'n')
endfunction
function! TermRunnerRun() abort
	call MakeTerm()
	call feedkeys(s:cmp . "\<CR>", 'n')
	call feedkeys(s:ex . "\<CR>", 'n')
endfunction

