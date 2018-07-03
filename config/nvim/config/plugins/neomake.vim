" https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/javascript.vim
" https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/go.vim

" let g:neomake_verbose = 0
" Auto open list and preserve the cursor position
let g:neomake_open_list = 2

let g:neomake_javascript_enabled_makers = ['eslint']

" When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('w', 750)

" gometalinter --install
" https://github.com/alecthomas/gometalinter
let g:neomake_go_enabled_makers = ['gometalinter']
" https://github.com/dominikh/go-tools/tree/master/cmd/megacheck
" let g:neomake_go_gometalinter_args = ['--disable-all',  '--enable=vetshadow', '--enable=errcheck', '--enable=megacheck']

" let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_warning_sign = {
"    \   'text': 'ℯ',
"    \   'texthl': 'NeomakeWarningSign',
"    \ }
" call neomake#signs#RedefineErrorSign()

" run neomake on the current file on every write
" augroup Neomake
"   autocmd!
"   autocmd BufWritePost * Neomake
" augroup END
