if !exists("b:yalp_loaded")
	let prefix = expand('<sfile>:p:h') . '/yalp/'

    execute 'source ' . fnamescape(prefix . 'jump.vim')
    execute 'source ' . fnamescape(prefix . 'shortcuts.vim')
    execute 'source ' . fnamescape(prefix . 'snippet.vim')
    execute 'source ' . fnamescape(prefix . 'list.vim')
    execute 'source ' . fnamescape(prefix . 'maps.vim')
    execute 'source ' . fnamescape(prefix . 'make.vim')

    let b:yalp_loaded = 1

endif
