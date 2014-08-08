""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Jump to the next `interesting` location                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Find the next interesting location after a given position  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Assume that location is of the form returned by getpos()

" Return value:
" [success?, line, column]
" success = 1 if there is a place to jump to; use call cursor(line, column)
" to actually make the move
" succes = 0 if not (so go to the end of the line)
function! FindNextInterestingLocation(location)
    let lineNumber = a:location[1]
    let columnNumber = a:location[2]

    let lineContent = getline(lineNumber)
    let columnEnd = col([lineNumber, '$'])


    " Start at the *next* cursor position so that we
    " don't get trapped at the current one
    let counter = columnNumber
    let offset = 0

    " Some adjustments:
    " * If we're at the beginning of a line, then move back one step
    "
    " Have to be more clever ...
    " if counter == 1
    "     let offset = -1
    " endif

    " If we are already at the end of the line, we have to go to the next line
    if columnNumber == columnEnd
        return [-1, lineNumber+1, columnEnd]
    endif

    " Loop through the current line to search for the
    " next interesting location
    while counter < columnEnd
        let current = lineContent[counter]
        let preceding = lineContent[counter - 1]
        let following = lineContent[counter + 1]

        " To set the cursor at the current location, use
        " `call cursor(lineNumber, counter+1)`

        " To set the cursor after current location, use
        " `call cursor(lineNumber, counter+2)`

        " if current == '$'
        "     return [5, lineNumber, counter]
        " endif
        " if following == '$'
        "     return [5, lineNumber, counter]
        " endif

        " Test this condition first because its column number is the
        " lowest
        if stridx("})]", current) >= 0 && stridx("-{[()]}", preceding) >=0
            return [3, lineNumber, counter+1+offset]
        endif

        " Jump before *and* after the dollar sign
        if current == '$'
            return [1, lineNumber, counter+1+offset]
        endif

        if preceding == '$'
            return [5, lineNumber, counter+1]
        endif


        if stridx("})]", current) >= 0 && stridx("({[_^", following) == -1
            return [2, lineNumber, counter+2+offset]
        endif

        if stridx(" ", following) >= 0
            return [4, lineNumber, counter+2+offset]
        endif

        let counter += 1
    endwhile

    " If no good positions, simply position ourselves at the end of the line
    return [0, lineNumber, columnNumber]
endfunction




""""""""""""""""""""""""""""""""""""
"  Jump from the current location  "
""""""""""""""""""""""""""""""""""""
function! Jump()
    let currentCol = getcurpos()[2]
    let result = FindNextInterestingLocation(getpos('.'))
    if result[0] > 0 && result[2] <= col('$')
        return repeat("\<Right>", result[2] - currentCol)
    endif
    if result[0] > 0 && result[2] > col('$')
        return "\<End>"
    endif
    if result[0] == 0
        return "\<End>"
    endif
    if result[0] == -1
        return "\<Down>\<End>"
    endif
    return result[0]
endfunction


inoremap <buffer> <silent> <expr> <Plug>JumpJump Jump()
