let s:save_cpo = &cpo
set cpo&vim


let g:watchdogs#default_config = {
\
\	"watchdogs_checker/_" : {
\		"runner" : "vimproc",
\		"outputter" : "quickfix",
\		"hook/hier_update/enable_exit" : 1,
\		"hook/quickfix_stateus_enable/enable_exit" : 1,
\	},
\
\
\	"c/watchdogs_checker" : {
\		"type" : "watchdogs_checker/gcc"
\	},
\
\	"watchdogs_checker/gcc" : {
\		"command"   : "gcc",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/clang" : {
\		"command"   : "clang",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\
\	"cpp/watchdogs_checker" : {
\		"type" : "watchdogs_checker/g++"
\	},
\
\	"watchdogs_checker/g++" : {
\		"command"   : "g++",
\		"exec"      : "%c %o -std=gnu++0x -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/g++03" : {
\		"command"   : "g++",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/clang++" : {
\		"command"   : "clang++",
\		"exec"      : "%c %o -std=gnu++0x -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/clang++03" : {
\		"command"   : "clang++",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/msvc" : {
\		"command"   : "cl",
\		"exec"      : "%c /Zs %o %s:p ",
\	},
\
\
\	"d/watchdogs_checker" : {
\		"type" : "watchdogs_checker/dmd",
\	},
\
\	"watchdogs_checker/dmd" : {
\		"command" : "dmd",
\		"exec"    : "%c %o -c %s:p",
\	},
\
\
\	"haskell/watchdogs_checker" : {
\		"type" : "watchdogs_checker/ghc-mod"
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
\
\	"javascript/watchdogs_checker" : {
\		"type" : "watchdogs_checker/jshint"
\	},
\
\	"watchdogs_checker/jshint" : {
\		"command" : "jshint",
\		"exec"    : "%c %s:p",
\		"quickfix/errorformat" : "%f: line %l\\,\ col %c\\, %m",
\	},
\
\
\	"lua/watchdogs_checker" : {
\		"type" : "watchdogs_checker/luac",
\	},
\
\	"watchdogs_checker/luac" : {
\		"command" : "luac",
\		"exec"    : "%c %o %s:p",
\		"quickfix/errorformat" : '%.%#: %#%f:%l: %m',
\	},
\
\
\	"perl/watchdogs_checker" : {
\		"type" : "watchdogs_checker/perl",
\	},
\
\	"watchdogs_checker/perl" : {
\		"command" : "perl",
\		"exec"    : "%c %o -c %s:p",
\		"quickfix/errorformat" : '%m\ at\ %f\ line\ %l%.%#',
\	},
\
\	"watchdogs_checker/vimparse.pl" : {
\		"command" : "perl",
\		"exec"    : "%c " . substitute(expand('<sfile>:p:h:h'), '\\', '\/', "g") . "/bin/vimparse.pl" . " -c %o %s:p",
\		"quickfix/errorformat" : '%f:%l:%m',
\	},
\
\
\	"php/watchdogs_checker" : {
\		"type" : "watchdogs_checker/php",
\	},
\
\	"watchdogs_checker/php" : {
\		"command" : "php",
\		"exec"    : "%c %o -l %s:p",
\		"quickfix/errorformat" : '%m\ in\ %f\ on\ line\ %l',
\	},
\
\
\	"python/watchdogs_checker" : {
\		"type" : "watchdogs_checker/pyflakes",
\	},
\	
\	"watchdogs_checker/pyflakes" : {
\		"command" : "pyflakes",
\		"exec"    : '%c %o %s:p',
\	},
\
\
\	"ruby/watchdogs_checker" : {
\		"type" : "watchdogs_checker/ruby"
\	},
\
\	"watchdogs_checker/ruby" : {
\		"command" : "ruby",
\		"exec"    : "%c %o -c %s:p",
\	},
\
\
\	"sass/watchdogs_checker" : {
\		"type" : "watchdogs_checker/sass",
\	},
\	"watchdogs_checker/sass" : {
\		"command" : "sass",
\		"exec"    : "%c %o --check ".(executable("compass") ? "--compass" : "")." %s:p",
\		"quickfix/errorformat"
\			: '%ESyntax %trror:%m,%C        on line %l of %f,%Z%.%#'
\			. ',%Wwarning on line %l:,%Z%m,Syntax %trror on line %l: %m',
\	},
\
\
\	"scss/watchdogs_checker" : {
\		"type" : "watchdogs_checker/scss",
\	},
\	"watchdogs_checker/scss" : {
\		"command" : "sass",
\		"exec"    : "%c %o --check ".(executable("compass") ? "--compass" : "")." %s:p",
\		"quickfix/errorformat"
\			: '%ESyntax %trror:%m,%C        on line %l of %f,%Z%.%#'
\			.',%Wwarning on line %l:,%Z%m,Syntax %trror on line %l: %m',
\	},
\
\
\	"scala/watchdogs_checker" : {
\		"type" : "watchdogs_checker/scalac"
\	},
\
\	"watchdogs_checker/scalac" : {
\		"command" : "scalac",
\		"exec"    : "%c %o %s:p",
\		"quickfix/errorformat"    : '%f:%l:\ error:\ %m,%-Z%p^,%-C%.%#,%-G%.%#',
\	 },
\
\
\	"sh/watchdogs_checker" : {
\		"type" : "watchdogs_checker/sh"
\	},
\
\	"watchdogs_checker/sh" : {
\		"command" : "sh",
\		"exec"    : "%c -n %o %s:p",
\		"quickfix/errorformat"    : '%f:\ line\ %l:%m',
\	 },
\
\
\	"zsh/watchdogs_checker" : {
\		"type" : "watchdogs_checker/sh"
\	},
\
\	"watchdogs_checker/zsh" : {
\		"command" : "zsh",
\		"exec"    : "%c -n %o %s:p",
\		"quickfix/errorformat"    : '%f:%l:%m',
\	 },
\
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
