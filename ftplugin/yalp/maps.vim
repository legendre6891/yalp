imap <buffer><silent> <Tab> <Plug>JumpJump
imap <buffer><silent> ` <Plug>ShortcutsBacktick
imap <buffer><silent> ; <Plug>ShortcutsSemicolon
imap <buffer><silent> ' <Plug>ShortcutsQuote

imap <buffer><silent> <C-Enter> <Plug>ListInsertNewListItem

inoremap <buffer> <C-Space> <C-X><C-O>


" Use autopairs instead of this!
inoremap <buffer> $ $$<Left>

inoremap <buffer> " ``''<Left><Left>

nnoremap <buffer> KK :Make<cr>
nnoremap <buffer> KL :make<cr>


" nnoremap <buffer> KK :silent :make!<cr>
" nnoremap <buffer> KL :make<cr>
