let g:user_emmet_install_global = 0
let g:user_emmet_complete_tag = 1

augroup EmmetSettings
  autocmd!
  " Allow to autocomplete hyphenated words
  autocmd FileType html,xml,css,scss,less setlocal iskeyword+=-
  " Enable emmet for following filetypes
  autocmd FileType html,xml,css,scss,less,markdown EmmetInstall
  autocmd FileType html,xml,css,scss,less,markdown imap <buffer>EE <Plug>(emmet-expand-abbr)
  autocmd FileType html,xml,css,scss,less,markdown imap <buffer><tab> <Plug>(emmet-move-next)
  autocmd FileType html,markdown vmap <buffer><Leader>ee <Plug>(emmet-expand-abbr)
  autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
  autocmd FileType css,scss nnoremap <silent> <leader>S viB:sort<CR>
augroup END
