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
function! s:FindNextInterestingLocation(location)
    let lineNumber = a:location[1]
    let columnNumber = a:location[2]

    let lineContent = getline(lineNumber)
    let columnEnd = col([lineNumber, '$'])


    " Start at the *next* cursor position so that we
    " don't get trapped at the current one
    let counter = columnNumber+1
    let offset = 0

    " Some adjustments:
    " * If we're at the beginning of a line, then move back one step
    "
    " Have to be more clever ...
    " if counter == 1
    "     let offset = -1
    " endif

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

        " Test this condition first because its column number is the
        " lowest
        if stridx("})]", current) >= 0 && stridx("-{[()]}", preceding) >=0
            return [3, lineNumber, counter+1+offset]
        endif

        if lineContent[counter] == '$'
            return [1, lineNumber, counter+1+offset]
        endif


        if stridx("})]", current) >= 0 && stridx("({[_^", following) == -1
            return [2, lineNumber, counter+2+offset]
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
    let result = s:FindNextInterestingLocation(getpos('.'))
    if result[0] > 0 && result[2] < col('$')
        call cursor(result[1], result[2])
        startinsert
    else
        startinsert!
    endif
    return
endfunction


inoremap <buffer> <Plug>JumpJump <Esc>:call Jump()<CR>
