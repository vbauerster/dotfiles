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

  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>jk <Plug>(go-doc-vertical)

  au FileType go nnoremap <leader>jf :FZFGoFiles<CR>
  au FileType go nnoremap <leader>jt :FZFTestGoFiles<CR>

  au FileType go nnoremap <leader>ji :GoDecls<CR>
  " jump g = packaGe scope
  au FileType go nnoremap <leader>jg :GoDeclsDir<CR>

  au FileType go nnoremap <silent><C-c><C-o>d :GoDescribe<CR>:setl nonumber<CR>
  au FileType go nnoremap <silent><C-c><C-o>i :GoImplements<CR>:setl nonumber<CR><C-w>L
  au FileType go nnoremap <silent><C-c><C-o>s :GoCallstack<CR>:setl nonumber<CR><C-w>L
  au FileType go nnoremap <silent><C-c><C-o>c :GoChannelPeers<CR>:setl nonumber<CR><C-w>L
  au FileType go vnoremap <silent><C-c><C-o>f :GoFreevars<CR>:setl nonumber<CR>
  au FileType go nnoremap <silent><C-c><C-o>r :GoReferrers<CR>:setl nonumber<CR>
  au FileType go nnoremap <silent><C-c><C-o>> :GoCallers<CR>:setl nonumber<CR><C-w>L
  au FileType go nnoremap <silent><C-c><C-o>< :GoCallees<CR>:setl nonumber<CR><C-w>L
  au FileType go nnoremap <silent><C-c><C-o>e :GoWhicherrs<CR>:setl nonumber<CR><C-w>L

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
