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
  autocmd!

  autocmd FileType go nmap <Leader>K <Plug>(go-doc-vertical)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  autocmd FileType go nnoremap <leader>jf :FZFGoFiles<CR>
  autocmd FileType go nnoremap <leader>jt :FZFTestGoFiles<CR>

  autocmd FileType go nnoremap <leader>ji :GoDecls<CR>
  autocmd FileType go nnoremap <leader>jd :GoDeclsDir<CR>

  autocmd FileType go nmap <F1> <Plug>(go-describe)
  autocmd FileType go nmap <S-F1> <Plug>(go-implements)

  autocmd FileType go nnoremap <F2> :up<CR>:Neomake<CR>
  autocmd FileType go nnoremap <S-F2> :GoFmtAutoSaveToggle<CR>

  autocmd FileType go nmap <F4> <Plug>(go-referrers)
  autocmd FileType go nmap <S-F4> <Plug>(go-callers)

  autocmd FileType go nmap <F5> <Plug>(go-channelpeers)
  autocmd FileType go nmap <S-F5> <Plug>(go-freevars)

  autocmd FileType go nmap <F6> <Plug>(go-rename)

  autocmd FileType go nmap <F7> <Plug>(go-sameids-toggle)
  " not related to go but...
  nnoremap <S-F7> :Highlight<CR>

  autocmd FileType go nmap <F8> <Plug>(go-test)
  autocmd FileType go nmap <S-F8> <Plug>(go-test-func)

  autocmd FileType go nmap <Leader>di <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
  autocmd FileType go setlocal tabstop=4
  autocmd FileType go setlocal softtabstop=4
  " autocmd FileType go setlocal shiftwidth=4
augroup END
