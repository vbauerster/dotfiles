func! Openpluginrepo()
    try
        exec "normal! ".'"ayi'."'"
        exec 'OpenBrowser https://github.com/'.@a
    catch
        echohl WarningMsg | echomsg "can not open the web of current plugin" | echohl None
    endtry
endf

func! Helptab()
  if &buftype == 'help'
    wincmd T
    nnoremap <buffer> q :q<CR>
  endif
endf
