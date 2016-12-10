"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Here, we define the necessary compatibility shortcuts
" for Ultisnips, which make TeX'ing much easier to work with.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <buffer><silent> $ $$<Left>
inoremap <buffer><silent> { {<C-R>=UltiSnips#Anon('\{$0\}', '{')<cr>
inoremap <buffer><silent> ( (<C-R>=UltiSnips#Anon('($0)', '(')<cr>
inoremap <buffer><silent> [ [<C-R>=UltiSnips#Anon('[$0]', '[')<cr>
inoremap <buffer><silent> // //<C-R>=UltiSnips#Anon('\\\{ $0 \\\}', '//')<cr>

inoremap <buffer><silent> _ _<C-R>=UltiSnips#Anon('_\{$0\}', '_')<cr>
inoremap <buffer><silent> ^ &<C-R>=UltiSnips#Anon('^\{$0\}', '^')<cr>
