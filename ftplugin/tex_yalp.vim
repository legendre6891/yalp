if !exists("b:yalp_loaded")
	let prefix = expand('<sfile>:p:h') . '/yalp/'

    execute 'source ' . fnameescape(prefix . 'jump.vim')
    execute 'source ' . fnameescape(prefix . 'shortcuts.vim')
    execute 'source ' . fnameescape(prefix . 'snippet.vim')
    execute 'source ' . fnameescape(prefix . 'list.vim')
    execute 'source ' . fnameescape(prefix . 'maps.vim')
    execute 'source ' . fnameescape(prefix . 'make.vim')

    let b:yalp_loaded = 1

endif
