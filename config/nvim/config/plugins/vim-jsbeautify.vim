augroup jsbeautify_conf
  autocmd!
  " autocmd FileType javascript nnoremap <buffer> <leader>f :call JsBeautify()<cr>
  " autocmd FileType json nnoremap <buffer> <leader>f :call JsonBeautify()<cr>
  " autocmd FileType jsx nnoremap <buffer> <leader>f :call JsxBeautify()<cr>
  " autocmd FileType html,xml nnoremap <buffer> <leader>f :call HtmlBeautify()<cr>
  " autocmd FileType css,scss nnoremap <buffer> <leader>f :call CSSBeautify()<cr>
  " beautify only selected lines
  " autocmd FileType javascript vnoremap <buffer>  <leader>f :call RangeJsBeautify()<cr>
  " autocmd FileType json vnoremap <buffer> <leade>f :call RangeJsonBeautify()<cr>
  " autocmd FileType jsx vnoremap <buffer> <leader>f :call RangeJsxBeautify()<cr>
  " autocmd FileType html,xml vnoremap <buffer> <leader>f :call RangeHtmlBeautify()<cr>
  " autocmd FileType css,scss vnoremap <buffer> <leader>f :call RangeCSSBeautify()<cr>
  autocmd BufWritePre *.js call JsBeautify()
  autocmd BufWritePre *.json call JsonBeautify()
  autocmd FileType json setlocal conceallevel&
augroup END
