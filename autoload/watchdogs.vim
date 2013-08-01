let s:save_cpo = &cpo
set cpo&vim


function! s:get_vimlint()
	return substitute(globpath(&rtp, "vimlint/vimlint.py"), '\\', '/', "g")
endfunction


function! s:executable_vimlint()
	return executable("python") && !empty(s:get_vimlint())
endfunction


function! s:get_vimlint_syngan_plugin_dir()
	return substitute(fnamemodify(globpath(&rtp, "autoload/vimlint.vim"), ":h:h"), '\\', '/', "g")
endfunction


function! s:get_vimlparser_plugin_dir()
	return substitute(fnamemodify(globpath(&rtp, "autoload/vimlparser.vim"), ":h:h"), '\\', '/', "g")
endfunction


function! s:executable_vim_vimlint()
	return filereadable(globpath(&rtp, "autoload/vimlparser.vim")) && filereadable(globpath(&rtp, "autoload/vimlint.vim"))
endfunction



let g:watchdogs#default_config = {
\
\	"watchdogs_checker/_" : {
\		"runner" : "vimproc",
\		"outputter" : "quickfix",
\		"hook/hier_update/enable_exit" : 1,
\		"hook/quickfix_stateus_enable/enable_exit" : 1,
\		"hook/shebang/enable" : 0,
\		"hook/quickfix_replate_tempname_to_bufnr/enable_exit" : 1,
\		"hook/quickfix_replate_tempname_to_bufnr/priority_exit" : -10,
\	},
\
\
\	"c/watchdogs_checker" : {
\		"type"
\			: executable("gcc")   ? "watchdogs_checker/gcc"
\			: executable("clang") ? "watchdogs_checker/clang"
\			: ""
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
\		"type"
\			: executable("clang-check") ? "watchdogs_checker/clang-check"
\			: executable("clang++")     ? "watchdogs_checker/clang++"
\			: executable("g++")         ? "watchdogs_checker/g++"
\			: executable("cl")          ? "watchdogs_checker/cl"
\			: "",
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
\	"watchdogs_checker/clang_check" : {
\		"command" : "clang-check",
\		"exec"    : "%c %s:p -- %o",
\		"cmdopt" : "--std=c++11",
\	},
\
\	"watchdogs_checker/msvc" : {
\		"command"   : "cl",
\		"exec"      : "%c /Zs %o %s:p ",
\	},
\
\   "watchdogs_checker/tsc" : {
\	    "command" : "tsc",
\	    "exec"    : "%c %s:p",
\	    "quickfix/errorformat" : '%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m',
\   },
\
\   "typescript/watchdogs_checker" : {
\	    "type" : "watchdogs_checker/tsc"
\   },
\
\	"coffee/watchdogs_checker" : {
\		"type"
\			: executable("coffeelint") ? "watchdogs_checker/coffeelint"
\			: executable("coffee")     ? "watchdogs_checker/coffee"
\			: ""
\	},
\
\	"watchdogs_checker/coffee" : {
\		"command" : "coffee",
\		"exec"    : "%c -c -l -o /tmp %o %s:p",
\		"quickfix/errorformat" : 'Syntax%trror: In %f\, %m on line %l,%EError: In %f\, Parse error on line %l: %m,%EError: In %f\, %m on line %l,%W%f(%l): lint warning: %m,%-Z%p^,%W%f(%l): warning: %m,%-Z%p^,%E%f(%l): SyntaxError: %m,%-Z%p^,%-G%.%#',
\	},
\
\	"watchdogs_checker/coffeelint" : {
\		"command" : "coffeelint",
\		"exec"    : "%c --csv %o %s:p",
\		"quickfix/errorformat" : '%f\,%l\,%trror\,%m',
\	},
\
\
\	"d/watchdogs_checker" : {
\		"type"
\			: executable("dmd") ? "watchdogs_checker/dmd"
\			: ""
\	},
\
\	"watchdogs_checker/dmd" : {
\		"command" : "dmd",
\		"exec"    : "%c %o -c %s:p",
\	},
\
\
\	"haskell/watchdogs_checker" : {
\		"type"
\			: executable("hlint")   ? "watchdogs_checker/hlint"
\			: executable("ghc-mod") ? "watchdogs_checker/ghc-mod"
\			: ""
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
\		"type"
\			: executable("jshint") ? "watchdogs_checker/jshint"
\			: ""
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
\		"type"
\			: executable("luac") ? "watchdogs_checker/luac"
\			: ""
\	},
\
\	"watchdogs_checker/luac" : {
\		"command" : "luac",
\		"exec"    : "%c %o -p %s:p",
\		"quickfix/errorformat" : '%.%#: %#%f:%l: %m',
\	},
\
\
\	"perl/watchdogs_checker" : {
\		"type"
\			: executable("perl") ? "watchdogs_checker/perl"
\			: ""
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
\		"type"
\			: executable("php") ? "watchdogs_checker/php"
\			: ""
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
\		"type"
\			: executable("pyflakes") ? "watchdogs_checker/pyflakes"
\			: ""
\	},
\	
\	"watchdogs_checker/pyflakes" : {
\		"command" : "pyflakes",
\		"exec"    : '%c %o %s:p',
\		"quickfix/errorformat" : '%f:%l:%m',
\	},
\
\	"ruby/watchdogs_checker" : {
\		"type"
\			: executable("ruby") ? "watchdogs_checker/ruby"
\			: ""
\	},
\
\	"watchdogs_checker/ruby" : {
\		"command" : "ruby",
\		"exec"    : "%c %o -c %s:p",
\	},
\
\
\	"sass/watchdogs_checker" : {
\		"type"
\			: executable("sass") ? "watchdogs_checker/sass"
\			: ""
\	},
\
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
\		"type"
\			: executable("sass") ? "watchdogs_checker/scss"
\			: ""
\	},
\
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
\		"type"
\			: executable("scalac") ? "watchdogs_checker/scalac"
\			: ""
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
\		"type"
\			: executable("sh") ? "watchdogs_checker/sh"
\			: ""
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
\		"type"
\			: executable("zsh") ? "watchdogs_checker/zsh"
\			: ""
\	},
\
\	"watchdogs_checker/zsh" : {
\		"command" : "zsh",
\		"exec"    : "%c -n %o %s:p",
\		"quickfix/errorformat"    : '%f:%l:%m',
\	 },
\
\
\	"vim/watchdogs_checker" : {
\		"type"
\			: s:executable_vim_vimlint() ? "watchdogs_checker/vimlint"
\			: s:executable_vimlint() ? "watchdogs_checker/vimlint_by_dbakker"
\			: ""
\	},
\
\	"watchdogs_checker/vimlint" : {
\		'command': 'vim',
\		"exec" : '%C -N -u NONE -i NONE -V1 -e -s -c "set rtp+=' . s:get_vimlparser_plugin_dir() . ',' . s:get_vimlint_syngan_plugin_dir() . '" -c "call vimlint#vimlint(''%s'', {})" -c "qall!"',
\		'outputter/quickfix/errorformat': '%f:%l:%c:%n: %m',
\	 },
\
\	"watchdogs_checker/vimlint_by_dbakker" : {
\		'command': 'python',
\		'exec': '%C ' . s:get_vimlint() . ' %s',
\		"runner" : "vimproc",
\		'outputter/quickfix/errorformat': '%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m',
\	},
\
\
\	"watchdogs_checker_dummy" : {}
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
