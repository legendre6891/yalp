let g:backtick_dictionary = {
    \ 'a' : ['\alpha'],
    \ 'b' : ['\beta'],
    \ 'c' : [],
    \ 'd' : ['\delta', '\partial'],
    \ 'e' : ['\epsilon', '\varepsilon'],
    \ 'f' : ['\phi', '\varphi'],
    \ 'F' : ['\Phi'],
    \ 'g' : ['\gamma'],
    \ 'h' : ['\eta'],
    \ 'i' : ['\in', '\iota'],
    \ 'j' : ['j'],
    \ 'k' : ['\kappa'],
    \ 'l' : ['\lambda'],
    \ 'L' : ['\Lambda'],
    \ 'm' : ['\mu'],
    \ 'n' : ['\nu'],
    \ 'N' : ['\nabla'],
    \ 'o' : ['\omega'],
    \ 'O' : ['\Omega'],
    \ 'p' : ['\pi'],
    \ 'q' : ['\theta', '\vartheta'],
    \ 'Q' : ['\Theta'],
    \ 'r' : ['\rho'],
    \ 's' : ['\sigma'],
    \ 'S' : ['\Sigma'],
    \ 't' : ['\tau'],
    \ 'u' : ['\upsilon'],
    \ 'v' : ['\vee'],
    \ 'w' : ['\xi'],
    \ 'x' : ['\chi'],
    \ 'y' : ['\psi'],
    \ 'Y' : ['\Psi'],
    \ 'z' : ['\zeta'],
    \ '0' : ['\emptyset'],
    \ '8' : ['\infty'],
    \ '.' : ['\cdot', '\dots'],
    \ '=' : ['\implies', '\impliedby', '\iff'],
    \ '/' : ['\frac{@}{}'],
    \ 'I' : ['\int_{@}^{}'],
    \ '(' : ['\bigl( @ \bigr)', '\biggl( @ \biggr)', '\left( @ \right)'],
    \ '<' : ['\langle @ \rangle', '\bigl< @ \bigr>', '\biggl< @ \biggr>'],
    \ '[' : ['\bigl[ @ \bigr]', '\biggl[ @ \biggr]', '\left[ @ \right]'],
    \ '|' : ['\bigl| @ \bigr|', '\biggl| @ \biggr|', '\left| @ \right|'],
    \ '{' : ['\bigl\{ @ \bigr\}', '\biggl\{ @ \biggr\}', '\left\{ @ \right\}']}


let g:quote_dictionary = {
    \ 't' : ['\text{@}'],
    \ 'q' : ['\quad'],
    \ 'e' : ['\emph{@}'],
    \ 'b' : ['\textbf{@}'],
    \ 'y' : ['\texttt{@}'],
    \ 'i' : ['\textit{@}']}

let g:semicolon_dictionary = {
    \ '/' : ['\frac{@}{}', '\dfrac{@}{}'],
    \ 'f' : ['\frac{@}{}', '\dfrac{@}{}'],
    \ 's' : ['\sum_{@}^{}'],
    \ 'p' : ['\prod_{@}^{}'],
    \ 'i' : ['\int_{@}^{}']}


function! s:InsertShortcut(kind, key, index)
    let dict = {}
    if a:kind == "`"
        let dict = g:backtick_dictionary
    elseif a:kind == ";"
        let dict = g:semicolon_dictionary
    elseif a:kind == "'"
        let dict = g:quote_dictionary
    endif

    if has_key(dict, a:key)
        let snips = dict[a:key]
        if a:index >= len(snips)
            return snippet#SimpleSnippetFactory(a:key)
        else
            return snippet#SimpleSnippetFactory(snips[a:index])
        endif
    else
        return snippet#SimpleSnippetFactory(a:key)
    endif
endfunction

function! HandleShortcut(char, max_level)
    let level = 1
    let next_char = a:char
    while level < a:max_level && next_char == a:char
        let next_char = nr2char(getchar())
        if next_char == a:char
            let level += 1
        endif
    endwhile

    if level == 4
        return a:char
    endif

    if next_char == "\<C-c>"
        return a:char
    endif

    return s:InsertShortcut(a:char, next_char, level-1)
endfunction



inoremap <buffer> <silent> <expr> <Plug>ShortcutsBacktick HandleShortcut('`', 4)
inoremap <buffer> <silent> <expr> <Plug>ShortcutsSemicolon HandleShortcut(';', 3)
inoremap <buffer> <silent> <expr> <Plug>ShortcutsQuote HandleShortcut("'", 2)

