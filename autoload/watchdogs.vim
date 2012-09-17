let s:save_cpo = &cpo
set cpo&vim


let g:watchdogs#default_config = {
\
\	"cpp/watchdogs_checker" : {
\		"type" : "watchdogs_checker/g++"
\	},
\
\	"ruby/watchdogs_checker" : {
\		"type" : "watchdogs_checker/ruby"
\	},
\
\	"javascript/watchdogs_checker" : {
\		"type" : "watchdogs_checker/jshint"
\	},
\
\	"haskell/watchdogs_checker" : {
\		"type" : "watchdogs_checker/ghc-mod"
\	},
\
\	"watchdogs_checker/_" : {
\		"runner" : "vimproc",
\		"outputter" : "quickfix",
\		"hook/hier_update/enable_exit" : 1,
\		"hook/quickfix_stateus_enable/enable_exit" : 1,
\	},
\
\	"watchdogs_checker/g++" : {
\		"command"   : "g++",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/msvc" : {
\		"command"   : "cl",
\		"exec"      : "%c /Zs %o %s:p ",
\	},
\
\	"watchdogs_checker/clang++" : {
\		"command"   : "clang++",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/ruby" : {
\		"command" : "ruby",
\		"exec"    : "%c %s:p %o -c",
\	},
\
\	"watchdogs_checker/jshint" : {
\		"command" : "jshint",
\		"exec"    : "%c %s:p",
\		"quickfix/errorformat" : "%f: line %l\\,\ col %c\\, %m",
\	},
\
\	"watchdogs_checker/ghc-mod" : {
\		"command" : "ghc-mod",
\		"exec"    : '%c %o --hlintOpt="--language=XmlSyntax" check %s:p',
\	},
\
\	"watchdogs_checker/hlint" : {
\		"command" : "hlint",
\		"exec"    : '%c %o %s:p',
\	},
\
\}


function! watchdogs#setup(config, ...)
	let flag = a:0 && a:1 ? "force" : "keep"
	for [type, config] in items(g:watchdogs#default_config)
		if has_key(a:config, type)
			let a:config[type] = extend(
\				a:config[type],
\				deepcopy(g:watchdogs#default_config[type]),
\				flag
\			)
		else
			let a:config[type] = deepcopy(config)
		endif
	endfor
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
