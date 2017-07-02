let g:go_gocode_unimported_packages = 1
" let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_types = 1
let g:go_term_enabled = 1
let g:go_fmt_command = "goimports"
" let g:go_snippet_engine = "neosnippet"

augroup GoLang
  autocmd!
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <F1> <Plug>(go-describe)

  " shift F2
  autocmd FileType go nnoremap <F2> :up<CR>:Neomake<CR>
  autocmd FileType go nnoremap <F14> :GoFmtAutoSaveToggle<CR>

  autocmd FileType go nnoremap <leader>gf :FZFGoFiles<CR>

  autocmd FileType go nmap <F9> <Plug>(go-test)
  autocmd FileType go nmap <F21> <Plug>(go-test-func)

  autocmd FileType go nmap <F5> <Plug>(go-build)

  autocmd FileType go nmap <F6> <Plug>(go-rename)

  autocmd FileType go nmap <F7> <Plug>(go-sameids-toggle)
  autocmd FileType go nmap <F19> <Plug>(go-callers)

  autocmd FileType go nmap <Leader>dx <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
  autocmd FileType go setlocal tabstop=4
  autocmd FileType go setlocal softtabstop=4
  " autocmd FileType go setlocal shiftwidth=4
augroup END
