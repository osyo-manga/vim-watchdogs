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


" let g:watchdogs#vimlint_config = get(g:, "watchdogs#vimlint_config", {})
let g:watchdogs#vimlint_empty_config = "{}"



let g:watchdogs#default_config = {
\
\	"watchdogs_checker/_" : {
\		"runner" : "vimproc",
\		"outputter" : "quickfix",
\		"hook/hier_update/enable_exit" : 1,
\		"hook/quickfix_status_enable/enable_exit" : 1,
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
\			: executable("clang-check") ? "watchdogs_checker/clang_check"
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
\
\	"typescript/watchdogs_checker" : {
\		"type"
\			: executable("tsc") ? "watchdogs_checker/tsc"
\			: ""
\	},
\
\	"watchdogs_checker/tsc" : {
\		"command" : "tsc",
\		"exec"	: "%c %s:p",
\		"errorformat" : '%+A\ %#%f\ %#(%l\\,%c):\ %m,%C%m',
\	},
\
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
\		"errorformat" : 'Syntax%trror: In %f\, %m on line %l,%EError: In %f\, Parse error on line %l: %m,%EError: In %f\, %m on line %l,%W%f(%l): lint warning: %m,%-Z%p^,%W%f(%l): warning: %m,%-Z%p^,%E%f(%l): SyntaxError: %m,%-Z%p^,%-G%.%#',
\	},
\
\	"watchdogs_checker/coffeelint" : {
\		"command" : "coffeelint",
\		"exec"    : "%c --csv %o %s:p",
\		"errorformat" : '%f\,%l\,%trror\,%m',
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
\	"go/watchdogs_checker" : {
\		"type"
\			: executable("gofmt") ? "watchdogs_checker/gofmt"
\			: executable("govet") ? "watchdogs_checker/govet"
\			: executable("go")    ? "watchdogs_checker/go_vet"
\			: ""
\	},
\
\	"watchdogs_checker/gofmt" : {
\		"command" : "gofmt",
\		"exec"    : "%c -l %o %s:p",
\		"errorformat" : '%f:%l:%c: %m,%-G%.%#',
\	},
\
\	"watchdogs_checker/govet" : {
\		"command" : "govet",
\		"exec"    : "%c %o %s:p",
\		"errorformat" : 'govet: %.%\+: %f:%l:%c: %m,%W%f:%l: %m,%-G%.%#',
\	},
\
\	"watchdogs_checker/go_vet" : {
\		"command" : "go",
\		"exec"    : "%c vet %o %s:p",
\		"errorformat" : 'vet: %.%\+: %f:%l:%c: %m,%W%f:%l: %m,%-G%.%#',
\	},
\
\
\	"haml/watchdogs_checker" : {
\		"type"
\			: executable("haml")   ? "watchdogs_checker/haml"
\			: ""
\	},
\
\	"watchdogs_checker/haml" : {
\		"command" : "haml",
\		"cmdopt" : "--check --trace",
\	},
\
\
\	"haskell/watchdogs_checker" : {
\		"type"
\			: executable("ghc-mod") ? "watchdogs_checker/ghc-mod"
\			: executable("hlint")   ? "watchdogs_checker/hlint"
\			: executable("hdevtools")   ? "watchdogs_checker/hdevtools"
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
\	"watchdogs_checker/hdevtools" : {
\		"command" : "hdevtools",
\		"exec"    : '%c check %o %s:p',
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
\		"exec"    : "%c %o %s:p",
\		"errorformat" : "%f: line %l\\,\ col %c\\, %m",
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
\		"errorformat" : '%.%#: %#%f:%l: %m',
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
\		"errorformat" : '%m\ at\ %f\ line\ %l%.%#',
\	},
\
\	"watchdogs_checker/vimparse.pl" : {
\		"command" : "perl",
\		"exec"    : "%c " . substitute(expand('<sfile>:p:h:h'), '\\', '\/', "g") . "/bin/vimparse.pl" . " -c %o %s:p",
\		"errorformat" : '%f:%l:%m',
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
\		"errorformat" : '%m\ in\ %f\ on\ line\ %l',
\	},
\
\
\	"python/watchdogs_checker" : {
\		"type"
\			: executable("pyflakes") ? "watchdogs_checker/pyflakes"
\			: executable("flake8") ? "watchdogs_checker/pyflakes"
\			: ""
\	},
\	
\	"watchdogs_checker/pyflakes" : {
\		"command" : "pyflakes",
\		"exec"    : '%c %o %s:p',
\		"errorformat" : '%f:%l:%m',
\	},
\	
\	"watchdogs_checker/flake8" : {
\		"command" : "flake8",
\		"exec"    : '%c %o %s:p',
\		"errorformat" : '%f:%l:%m',
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
\	"watchdogs_checker/rubocop" : {
\		"command" : "rubocop",
\		"exec"    : "%c %o %s:p",
\		"errorformat" : '%f:%l:%c:%m',
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
\		"errorformat"
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
\		"errorformat"
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
\		"exec"    : "%c %o -Ystop-after:parser %s:p",
\		"errorformat"    : '%f:%l:\ error:\ %m,%-Z%p^,%-C%.%#,%-G%.%#',
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
\		"errorformat"    : '%f:\ line\ %l:%m',
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
\		"errorformat"    : '%f:%l:%m',
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
\		"exec" : '%C -N -u NONE -i NONE -V1 -e -s -c "set rtp+=' . s:get_vimlparser_plugin_dir() . ',' . s:get_vimlint_syngan_plugin_dir() . '" -c "call vimlint#vimlint(''%s'', %{ exists(''g:vimlint#config'') ? string(g:vimlint#config) : g:watchdogs#vimlint_empty_config })" -c "qall!"',
\		'errorformat': '%f:%l:%c:%trror: %m,%f:%l:%c:%tarning: %m,%f:%l:%c:%m',
\	 },
\
\	"watchdogs_checker/vimlint_by_dbakker" : {
\		'command': 'python',
\		'exec': '%C ' . s:get_vimlint() . ' %s',
\		"runner" : "vimproc",
\		'errorformat': '%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m',
\	},
\
\
\	"watchdogs_checker_dummy" : {}
\}


function! watchdogs#setup(config, ...)
	let flag = a:0 && a:1 ? "force" : "keep"
	let base = "watchdogs_checker/_"
	let a:config[base] = extend(get(a:config, base, {}), g:watchdogs#default_config[base], flag)
" 	PP a:config[base]
	for [type, config] in items(g:watchdogs#default_config)
		if has_key(a:config, type)
			let a:config[type] = extend(
\				a:config[type],
\				g:watchdogs#default_config[type],
\				flag
\			)
		else
			let a:config[type] = deepcopy(config)
		endif
	endfor

	for [type, config] in items(a:config)
		if type =~# '^watchdogs_checker/.\+$'
			let a:config[type] = extend(
\				a:config[type],
\				a:config[base],
\				flag
\			)
		endif
	endfor

	return a:config
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
