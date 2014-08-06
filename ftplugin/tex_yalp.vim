if exists('*fnameescape')
    function! s:FNameEscape(s)
        return fnameescape(a:s)
    endfunction
else
    function! s:FNameEscape(s)
        return a:s
    endfunction
endif


if !exists("b:yalp_loaded")
	let prefix = expand('<sfile>:p:h') . '/yalp/'

    execute 'source ' . s:FNameEscape(prefix . 'jump')
    execute 'source ' . s:FNameEscape(prefix . 'hotkeys')
    execute 'source ' . s:FNameEscape(prefix . 'make')

    let b:yalp_loaded = 1

endif
