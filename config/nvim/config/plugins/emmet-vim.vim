let g:user_emmet_install_global = 0
let g:user_emmet_complete_tag = 1

augroup Emmetable
  autocmd!
  " Allow to autocomplete hyphenated words
  autocmd FileType html,xml,xsl,xslt,xsd,css,sass,scss,less,mustache setlocal iskeyword+=-
  " Enable emmet for following filetypes
  autocmd FileType html,xml,xsl,xslt,xsd,css,sass,scss,less,mustache,markdown EmmetInstall
  " autocmd FileType xml,xsl,xslt,xsd,css,sass,scss,less,mustache,html,markdown imap <buffer><expr><TAB> <SID>tabComplete("emmetable")
  autocmd FileType html,markdown vmap <buffer><Leader>ee <c-y>,
  autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
  autocmd FileType css,scss nnoremap <silent> <leader>S viB:sort<CR>
augroup END
