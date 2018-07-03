let g:go_auto_sameids = 1
let g:go_updatetime = 500
let g:go_gocode_unimported_packages = 1
" let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_types = 1
let g:go_term_enabled = 1
let g:go_fmt_command = "goimports"
let g:go_fold_enable = ['import']

augroup GoLang
  au!

  " au FileType go nmap <Leader>i <Plug>(go-info)
  " au FileType go nmap <silent><C-c><C-d> <Plug>(go-doc-vertical)
  au FileType go nmap <silent><Leader><Enter> :GoInfo<CR>
  au FileType go nmap <silent><C-c><C-d> :GoDoc<CR>

  au FileType go nnoremap <leader>jf :FZFGoFiles<CR>
  au FileType go nnoremap <leader>jt :FZFTestGoFiles<CR>

  au FileType go nnoremap <leader>jj :GoDecls<CR>
  au FileType go nnoremap <leader>jk :GoDeclsDir<CR>

  au FileType go nnoremap <silent><C-c><C-o>d :GoDescribe<CR>
  au FileType go nnoremap <silent><C-c><C-o>i :GoImplements<CR>
  au FileType go nnoremap <silent><C-c><C-o>s :GoCallstack<CR>
  au FileType go nnoremap <silent><C-c><C-o>c :GoChannelPeers<CR>
  au FileType go vnoremap <silent><C-c><C-o>f :GoFreevars<CR>
  au FileType go nnoremap <silent><C-c><C-o>r :GoReferrers<CR>
  au FileType go nnoremap <silent><C-c><C-o>> :GoCallers<CR>
  au FileType go nnoremap <silent><C-c><C-o>< :GoCallees<CR>
  au FileType go nnoremap <silent><C-c><C-o>e :GoWhicherrs<CR>

  " autocmd FileType go nnoremap <F2> :up<CR>:Neomake<CR>
  au FileType go nnoremap <S-F2> :GoFmtAutoSaveToggle<CR>

  au FileType go nmap <F6> <Plug>(go-rename)
  au FileType go nmap <F7> <Plug>(go-sameids-toggle)
  " not related to go but...
  nnoremap <S-F7> :Highlight<CR>

  au FileType go nmap <F8> <Plug>(go-test)
  au FileType go nmap <S-F8> <Plug>(go-test-func)

  au FileType go nmap <Leader>di <Plug>(go-def-split)
  au FileType go nmap <Leader>ds <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
augroup END
