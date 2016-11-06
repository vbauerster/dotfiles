function! s:OpenPluginRepo()
  try
    exec "normal! ".'"ayi'."'"
    exec 'OpenBrowser https://github.com/'.@a
  catch
    echohl WarningMsg | echomsg "can not open the web of current plugin" | echohl None
  endtry
endfunction

nnoremap <silent> <leader>px :call <SID>OpenPluginRepo()<CR>
