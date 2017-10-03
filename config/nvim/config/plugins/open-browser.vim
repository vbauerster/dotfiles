function! s:OpenPluginRepo()
  try
    exec "normal! ".'"ayi'."'"
    exec 'OpenBrowser https://github.com/'.@a
  catch
    echohl WarningMsg | echomsg "can not open the web of current plugin" | echohl None
  endtry
endfunction

function! s:OpenGoImport()
  try
    exec "normal! ".'"ayi"'
    exec 'OpenBrowser https://'.@a
  catch
    echohl WarningMsg | echomsg "can not open the web of current plugin" | echohl None
  endtry
endfunction

nnoremap <leader>px :call <SID>OpenPluginRepo()<CR>
nnoremap <leader>oo :call <SID>OpenGoImport()<CR>

let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
