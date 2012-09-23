scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


let s:hook = {
\	"config" : {
\		"enable" : 1
\	},
\}

function! s:hook.init(...)
	if self.config.enable
		let g:watchdogs_quickrun_running_check = 1
	endif
endfunction

function! s:hook.on_exit(...)
	let g:watchdogs_quickrun_running_check = 0
endfunction


function! quickrun#hook#watchdogs_quickrun_running_checker#new()
	return deepcopy(s:hook)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
