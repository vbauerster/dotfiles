" https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/javascript.vim
" https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/go.vim

let g:neomake_verbose = 0
" let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint']

" gometalinter --install
" https://github.com/alecthomas/gometalinter
let g:neomake_go_enabled_makers = ['gometalinter']
" default is: ['--disable-all', '--enable=errcheck', '--enable=gosimple', '--enable=staticcheck', '--enable=unused']
let g:neomake_go_gometalinter_args = ['--disable-all', '--enable=errcheck',  '--enable=vet',   '--enable=vetshadow', '--enable=gosimple', '--enable=staticcheck', '--enable=interfacer',  '--enable=unconvert']

" let g:neomake_error_sign = {'text': '✖', 'texthl': 'GruvboxRedSign'}
" let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'GruvboxYellowSign'}
let g:neomake_warning_sign = {'texthl': 'GruvboxYellowSign'}

" run neomake on the current file on every write
augroup Neomake
  autocmd!
  autocmd BufWritePost * Neomake
augroup END
