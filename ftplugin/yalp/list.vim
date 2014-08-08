" Depending on the current environment
" insert the next list item structure.
"
" e.g. in an enumerate environment, insert \item
" in a description environment, insert \item[@]
" in align environment, insert \\ REF#
"
" Defaults to the empty string
function! InsertNewListItem()
    let env = LatexBox_GetCurrentEnvironment()

    if env == "enumerate" || env == "itemize"
        return snippet#SimpleSnippetFactory("\\item")
    endif

    if env == "description"
        return snippet#SimpleSnippetFactory("\\item[@]")
    endif

    if env == "align"
        return snippet#SimpleSnippetFactory("\\\\")
    endif
endfunction


inoremap <buffer> <silent> <expr> <Plug>ListInsertNewListItem InsertNewListItem()
