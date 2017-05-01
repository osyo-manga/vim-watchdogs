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
\		"outputter/quickfix/open_cmd" : "cwindow",
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
\			: executable("g++")         ? "watchdogs_checker/g++"
\			: executable("clang++")     ? "watchdogs_checker/clang++"
\			: executable("cl")          ? "watchdogs_checker/cl"
\			: "",
\	},
\
\	"watchdogs_checker/g++" : {
\		"command"   : "g++",
\		"exec"      : "%c -std=gnu++0x %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/g++03" : {
\		"command"   : "g++",
\		"exec"      : "%c %o -fsyntax-only %s:p ",
\	},
\
\	"watchdogs_checker/clang++" : {
\		"command"   : "clang++",
\		"exec"      : "%c -std=gnu++0x %o -fsyntax-only %s:p ",
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
\			: executable("tsc")    ? "watchdogs_checker/tsc"
\			: executable("tslint") ? "watchdogs_checker/tslint"
\			: ""
\	},
\
\	"watchdogs_checker/tsc" : {
\		"command" : "tsc",
\		"exec"	: "%c %s:p",
\		"errorformat" : '%+A\ %#%f\ %#(%l\\,%c):\ %m,%C%m',
\	},
\
\	"watchdogs_checker/tslint" : {
\		"command" : "tslint",
\		"exec"	: "%c %s:p",
\		"errorformat" : '%f[%l\\,\ %c]:\ %m',
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
\	"css/watchdogs_checker" : {
\		"type"
\			: executable("csslint") ? "watchdogs_checker/csslint"
\			: executable("stylelint") ? "watchdogs_checker/stylelint"
\			: ""
\	},
\
\	"watchdogs_checker/csslint" : {
\		"command" : "csslint",
\		"exec"    : "%c --format=compact %o %s:p",
\		"errorformat" : '%f:\ line\ %l\\,\ col\ %c\\,\ %m',
\	},
\
\	"watchdogs_checker/stylelint" : {
\		"command" : "stylelint",
\		"exec"    : "%c %o %s:p",
\		"errorformat" : '%+P%f,%*\s%l:%c%*\s%m,%-Q',
\	},
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
\			: executable("gofmt")  ? "watchdogs_checker/gofmt"
\			: executable("govet")  ? "watchdogs_checker/govet"
\			: executable("golint") ? "watchdogs_checker/golint"
\			: executable("go")     ? "watchdogs_checker/go_vet"
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
\	"watchdogs_checker/golint" : {
\		"command" : "golint",
\		"exec"    : "%c %o %s:p",
\		"errorformat" : '%f:%l:%c: %m',
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
\			: executable("haml-lint")   ? "watchdogs_checker/haml-lint"
\			: ""
\	},
\
\	"watchdogs_checker/haml" : {
\		"command" : "haml",
\		"cmdopt" : "--check --trace",
\	},
\
\	"watchdogs_checker/haml-lint" : {
\		"command" : "haml-lint",
\		"exec"    : "%c --no-color %o %s:p",
\		"errorformat" : '%f:%l \\[%t\\] %m',
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
\		"exec"    : '%c %o check %s:p',
\		"errorformat" : '%f:%l:%c:%trror: %m,%f:%l:%c:%tarning: %m,%f:%l:%c:parse %trror %m,%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l:%c:%m,%E%f:%l:%c:,%Z%m',
\		"tempfile": 'TemporaryWatchDogSourceFile.hs'
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
\	"java/watchdogs_checker" : {
\		"type"
\			: executable("javac") ? "watchdogs_checker/javac"
\			: ""
\	},
\
\	"watchdogs_checker/javac" : {
\		"command" : "javac",
\		"exec"    : "%c -d " . (
\						  exists('$TEMP') ? $TEMP
\						: exists('$TMP') ? $TMP
\						: exists('$TMPDIR') ? $TMPDIR
\						: "") .
\					" %o %S:p",
\		"errorformat" : '%tarning: %m,%-G%*\d error,%-G%*\d warnings,%f:%l: %trror: %m,%f:%l: %tarning: %m,%+G%.%#',
\	},
\
\
\	"javascript/watchdogs_checker" : {
\		"type"
\			: executable("jshint") ? "watchdogs_checker/jshint"
\			: executable("eslint") ? "watchdogs_checker/eslint"
\			: ""
\	},
\
\	"watchdogs_checker/jshint" : {
\		"command" : "jshint",
\		"exec"    : "%c %o %s:p",
\		"errorformat" : '%f: line %l\,\ col %c\, %m, %-G%.%#',
\	},
\
\	"watchdogs_checker/eslint" : {
\		"command" : "eslint",
\		"exec"    : "%c -f compact %o %s:p",
\		"errorformat" : '%E%f: line %l\, col %c\, Error - %m,' .
\						'%W%f: line %l\, col %c\, Warning - %m,' .
\						'%-G%.%#',
\	},
\
\	"json/watchdogs_checker" : {
\		"type"
\			: executable("jsonlint") ? "watchdogs_checker/jsonlint"
\			: ""
\	},
\
\	"watchdogs_checker/jsonlint" : {
\		"command" : "jsonlint",
\		"exec"    : "%c %o -c %s:p",
\		"errorformat" : '%f: line %l\\, col %c\\, %m',
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
\	"nim/watchdogs_checker" : {
\		"type" : "watchdogs_checker/nim",
\	},
\
\	"watchdogs_checker/nim" : {
\		"command" : "nim",
\		"cmdopt"  : "check",
\		"errorformat" : '%-GHint: %m,%E%f(%l\, %c) Error: %m,%W%f(%l\, %c) Hint: %m',
\	},
\
\
\	"markdown/watchdogs_checker" : {
\		"type"
\			: executable("redpen") ? "watchdogs_checker/redpen"
\			: executable("textlint") ? "watchdogs_checker/textlint"
\			: executable("mdl") ? "watchdogs_checker/mdl"
\			: executable("eslint-md") ? "watchdogs_checker/eslint-md"
\			: ""
\	},
\
\	"watchdogs_checker/textlint" : {
\		"command" : "textlint",
\		"exec"    : "%c -f compact %o %s:p",
\		"errorformat" : '%E%f: line %l\, col %c\, Error - %m,' .
\						'%W%f: line %l\, col %c\, Warning - %m,' .
\						'%-G%.%#'
\	},
\
\	"watchdogs_checker/mdl" : {
\		"command"     : "mdl",
\		"errorformat" : "%E%f:%l: %m," .
\										"%W%f: Kramdown Warning: %m found on line %l"
\	},
\
\	"watchdogs_checker/eslint-md" : {
\		"command" : "eslint-md",
\		"exec"    : "%c -f compact %o %s:p",
\		"errorformat" : '%E%f: line %l\, col %c\, Error - %m,' .
\						'%W%f: line %l\, col %c\, Warning - %m,' .
\						'%-G%.%#',
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
\			: executable("phpcs") ? "watchdogs_checker/phpcs"
\			: executable("phpmd") ? "watchdogs_checker/phpmd"
\			: ""
\	},
\
\	"watchdogs_checker/php" : {
\		"command" : "php",
\		"exec"    : "%c %o -l %s:p",
\		"errorformat" : '%m\ in\ %f\ on\ line\ %l',
\	},
\
\	"watchdogs_checker/phpcs" : {
\		"command" : "phpcs",
\		"exec"    : "%c --report=emacs %o %s:p",
\		"errorformat" : '%f:%l:%c:\ %m',
\	},
\
\	"watchdogs_checker/phpmd" : {
\		"command" : "phpmd",
\		"exec"    : "%c %s:p text %o",
\		"cmdopt"  : "cleancode,codesize,design,naming,unusedcode",
\		"errorformat" : '%f:%l%\s%m,%-G%.%#',
\	},
\
\
\	"python/watchdogs_checker" : {
\		"type"
\			: executable("flake8") ? "watchdogs_checker/flake8"
\			: executable("pyflakes") ? "watchdogs_checker/pyflakes"
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
\		"errorformat" : '%f:%l:%c: %m',
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
\	"rust/watchdogs_checker" : {
\		"type"
\			: executable("rustc") ? "watchdogs_checker/rustc"
\			: ""
\	},
\
\	"watchdogs_checker/rustc" : {
\		"command" : "rustc",
\		"exec"    : '%c %o %s:p',
\		"cmdopt" : "-Z no-trans",
\		"errorformat"
\			: '%-Gerror: aborting %.%#,'
\			. '%-Gerror: Could not compile %.%#,'
\			. '%Eerror: %m,'
\			. '%Eerror[E%n]: %m,'
\			. '%Wwarning: ,'
\			. '%C %#--> %f:%l:%c'
\	},
\
\	"watchdogs_checker/rustc_parse-only" : {
\		"command" : "rustc",
\		"exec"    : '%c %o %s:p',
\		"cmdopt" : "-Z parse-only",
\		"errorformat"
\			: '%E%f:%l:%c: %\d%#:%\d%# %.%\{-}error:%.%\{-} %m'
\			. ',%W%f:%l:%c: %\d%#:%\d%# %.%\{-}warning:%.%\{-} %m'
\			. ',%C%f:%l %m'
\			. ',%-Z%.%#',
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
\			: executable("scss-lint") ? "watchdogs_checker/scss-lint"
\			: executable("stylelint") ? "watchdogs_checker/stylelint"
\			: "",
\		"cmdopt"
\			: executable("sass") ? ""
\			: executable("scss-lint") ? ""
\			: executable("stylelint") ? "--syntax scss"
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
\	"watchdogs_checker/scss-lint" : {
\		"command" : "scss-lint",
\		"exec"    : "%c %o %s:p",
\		"errorformat" : '%f:%l\ %m, %-G%.%#',
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
\			: executable("shellcheck") ? "watchdogs_checker/shellcheck"
\			: executable("bashate") ? "watchdogs_checker/bashate"
\			: executable("checkbashisms") ? "watchdogs_checker/checkbashisms"
\			: ""
\	},
\
\	"watchdogs_checker/sh" : {
\		"command" : "sh",
\		"exec"    : "%c -n %o %s:p",
\		"errorformat"    : '%f:\ line\ %l:%m',
\	 },
\
\	"watchdogs_checker/shellcheck" : {
\		"command" : "shellcheck",
\		'cmdopt'  : '-f gcc',
\	 },
\
\	"watchdogs_checker/bashate" : {
\		"command"     : "bashate",
\		"errorformat" : "%E[E] %m,%W[W] %m,%Z - %f : L%l,%-G%.%#",
\	 },
\
\	"watchdogs_checker/checkbashisms" : {
\		"command"     : "checkbashisms",
\		"errorformat" : "%-Gscript %f is already a bash script; skipping," .
\										"%Eerror: %f: %m\, opened in line %l," .
\										"%Eerror: %f: %m," .
\										"%Ecannot open script %f for reading: %m," .
\										"%Wscript %f %m,%C%.# lines," .
\										"%Wpossible bashism in %f line %l (%m):,%C%.%#,%Z.%#," .
\										"%-G%.%#"
\	},
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
\			: executable("vint") ? "watchdogs_checker/vint"
\			: s:executable_vim_vimlint() ? "watchdogs_checker/vimlint"
\			: s:executable_vimlint() ? "watchdogs_checker/vimlint_by_dbakker"
\			: ""
\	},
\
\	"watchdogs_checker/vint" : {
\		'command': 'vint',
\		"exec" : '%c %o %s',
\	 },
\
\	"watchdogs_checker/vimlint" : {
\		'command': 'vim',
\		"exec" : '%C -X -N -u NONE -i NONE -V1 -e -s -c "set rtp+=' . s:get_vimlparser_plugin_dir() . ',' . s:get_vimlint_syngan_plugin_dir() . '" -c "call vimlint#vimlint(''%s'', %{ exists(''g:vimlint#config'') ? string(g:vimlint#config) : g:watchdogs#vimlint_empty_config })" -c "qall!"',
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
\	"watchdogs_checker/redpen" : {
\		"command" : "redpen",
\		"exec"    : "%c %o %s:p",
\	},
\
\
\	"yaml/watchdogs_checker" : {
\		"type"
\			: executable("yaml-lint") ? "watchdogs_checker/yaml-lint"
\			: ""
\	},
\
\	"watchdogs_checker/yaml-lint" : {
\		"command"     : "yaml-lint",
\		'cmdopt'      : '-q',
\		"errorformat" : "%.%#(%f): %m at line %l column %c%.%#"
\	 },
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
