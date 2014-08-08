function! snippet#SimpleSnippetFactory(string)
    let at_symbol_index = stridx(a:string, "@")
    if at_symbol_index >= 0
        let length = len(a:string)
        return a:string . repeat("\<Left>", length - at_symbol_index) . "\<Del>"
    else
        return a:string
    endif
endfunction
