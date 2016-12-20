if exists('g:loaded_watchdogs')
  finish
endif
let g:loaded_watchdogs = 1

let s:save_cpo = &cpo
set cpo&vim


function! s:watchdogs_type(filetype)
	if empty(a:filetype)
		return ""
	endif
	return get(b:, "watchdogs_checker_type", a:filetype."/watchdogs_checker")
endfunction


function! s:is_empty_type(type)
	return a:type =~# '^.\+/watchdogs_checker$'
\	&& empty(get(get(g:quickrun_config, a:type, {}), "type", ""))
endfunction


function! s:setup_quickrun_config()
	if !exists("g:quickrun_config")
		let g:quickrun_config = {}
	endif
	if !has_key(g:quickrun_config, "watchdogs_checker_dummy")
		call watchdogs#setup(g:quickrun_config)
	endif
endfunction


function! s:run(args, deftype, ...)
	let is_output_msg = a:0 ? a:1 : 0
	call s:setup_quickrun_config()

	let config = quickrun#config(a:args)
	if !has_key(config, "type")
		let config.type = a:deftype
	endif

	if empty(config.type)
\	|| s:is_empty_type(get(config, "type", ""))
		if is_output_msg
			echoerr "==watchdogs error== Not support filetype " . config.type
		endif
		return
	endif

	call quickrun#run(config)
endfunction


command! -nargs=* -range=0 -complete=customlist,quickrun#complete
\	WatchdogsRun call s:run(<q-args>,s:watchdogs_type(&filetype),  1)

command! -nargs=* -range=0 -complete=customlist,quickrun#complete
\	WatchdogsRunSilent call s:run(<q-args>,s:watchdogs_type(&filetype), 0)

command! -nargs=0
\	WatchdogsRunSweep call quickrun#sweep_sessions()


let g:watchdogs_quickrun_running_check =
\	get(g:, "watchdogs_quickrun_running_check", 0)


let g:watchdogs_check_BufWritePost_enable =
\	get(g:, "watchdogs_check_BufWritePost_enable", 0)

let g:watchdogs_check_BufWritePost_enables =
\	get(g:, "watchdogs_check_BufWritePost_enables", {})

let g:watchdogs_check_BufWritePost_enable_on_wq =
\	get(g:, "watchdogs_check_BufWritePost_enable_on_wq", 1)


let s:called_quit_pre = 0
function! s:watchdogs_check_bufwrite(filetype)
	if !g:watchdogs_check_BufWritePost_enable_on_wq && s:called_quit_pre
		let s:called_quit_pre = 0
		return
	endif
	let s:called_quit_pre = 0
	if exists("*quickrun#is_running")
		if quickrun#is_running()
			return
		endif
	else
		if g:watchdogs_quickrun_running_check
			return
		endif
	endif
	if (g:watchdogs_check_BufWritePost_enable
\	|| get(g:watchdogs_check_BufWritePost_enables, a:filetype, 0))
\	&& get(g:watchdogs_check_BufWritePost_enables, a:filetype, 1)
		WatchdogsRunSilent -hook/watchdogs_quickrun_running_checker/enable 0
	endif
endfunction


let g:watchdogs_check_CursorHold_enable =
\	get(g:, "watchdogs_check_CursorHold_enable", 0)

let g:watchdogs_check_CursorHold_enables =
\	get(g:, "watchdogs_check_CursorHold_enables", {})


function! s:watchdogs_check_cursorhold(filetype)
	if exists("*quickrun#is_running")
		if quickrun#is_running()
			return
		endif
	else
		if g:watchdogs_quickrun_running_check
			return
		endif
	endif
	if get(b:, "watchdogs_checked_cursorhold", 1)
		return
	endif

	if (g:watchdogs_check_CursorHold_enable
\	|| get(g:watchdogs_check_CursorHold_enables, a:filetype, 0))
\	&& get(g:watchdogs_check_CursorHold_enables, a:filetype, 1)
		let b:watchdogs_checked_cursorhold=1
		WatchdogsRunSilent -hook/watchdogs_quickrun_running_checker/enable 0
	endif
endfunction


augroup watchdogs-plugin
	autocmd!
	autocmd QuitPre * let s:called_quit_pre = 1
	autocmd CursorMoved * let s:called_quit_pre = 0
	autocmd BufWritePost * call <SID>watchdogs_check_bufwrite(&filetype)

	autocmd BufWritePost * let b:watchdogs_checked_cursorhold = 0
	autocmd CursorHold   * call <SID>watchdogs_check_cursorhold(&filetype)
augroup END



let &cpo = s:save_cpo
unlet s:save_cpo
