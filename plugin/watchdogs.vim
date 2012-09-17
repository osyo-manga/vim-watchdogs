if exists('g:loaded_watchdogs')
  finish
endif
let g:loaded_watchdogs = 1

let s:save_cpo = &cpo
set cpo&vim


function! s:watchdogs_type(filetype)
	return get(b:, "watchdogs_checker_type", a:filetype."/watchdogs_checker")
endfunction


function! s:run(type, args, ...)
	let is_output_msg = a:0 ? a:1 : 0
	if !has_key(g:quickrun_config, a:type)
		if is_output_msg
			echoerr "==watchdogs error== Not found -type ".a:type
		endif
		return
	endif
	execute
\		"QuickRun "
\		"-type ".a:type." ".
\		"-hook/extend_config/enable 1 -hook/extend_config/force 1 ".
\		a:args
endfunction


command! -nargs=* -range=0 -complete=customlist,quickrun#complete
\	WachdogsRun call s:run(s:watchdogs_type(&filetype), <q-args>, 1)

command! -nargs=* -range=0 -complete=customlist,quickrun#complete
\	WachdogsRunSilent call s:run(s:watchdogs_type(&filetype), <q-args>)



let g:watchdogs_check_BufWritePost_enable =
\	get(g:, "watchdogs_check_BufWritePost_enable", 0)

let g:watchdogs_check_BufWritePost_enables =
\	get(g:, "watchdogs_check_BufWritePost_enables", {})


function! s:watchdogs_check_bufwrite(filetype)
	if (g:watchdogs_check_BufWritePost_enable
\	|| get(g:watchdogs_check_BufWritePost_enables, a:filetype, 0))
\	&& get(g:watchdogs_check_BufWritePost_enables, a:filetype, 1)
		WachdogsRunSilent
	endif
endfunction


let g:watchdogs_check_CursorHold_enable =
\	get(g:, "watchdogs_check_CursorHold_enable", 0)

let g:watchdogs_check_CursorHold_enables =
\	get(g:, "watchdogs_check_CursorHold_enables", {})


function! s:watchdogs_check_cursorhold(filetype)
	if get(b:, "watchdogs_checked_cursorhold", 1)
		return
	endif
	if (g:watchdogs_check_CursorHold_enable
\	|| get(g:watchdogs_check_CursorHold_enables, a:filetype, 0))
\	&& get(g:watchdogs_check_CursorHold_enables, a:filetype, 1)
		WachdogsRunSilent
		let b:watchdogs_checked_cursorhold=1
	endif
endfunction


augroup watchdogs-plugin
	autocmd!
	autocmd BufWritePost * call <SID>watchdogs_check_bufwrite(&filetype)

	autocmd BufWritePost * let b:watchdogs_checked_cursorhold = 0
	autocmd CursorHold   * call <SID>watchdogs_check_cursorhold(&filetype)
augroup END



let &cpo = s:save_cpo
unlet s:save_cpo
