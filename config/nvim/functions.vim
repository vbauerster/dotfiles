function! MyTabfunc() abort
    if getline('.')[col('.')-2] =='{'&& pumvisible()
        return "\<C-n>"
    endif
    if neosnippet#expandable() && getline('.')[col('.')-2] =='(' && !pumvisible()
        return "\<Plug>(neosnippet_expand)"
    elseif neosnippet#jumpable() && getline('.')[col('.')-2] =='(' && !pumvisible() && !neosnippet#expandable()
        return "\<plug>(neosnippet_jump)"
    elseif neosnippet#expandable_or_jumpable() && getline('.')[col('.')-2] !='('
        return "\<plug>(neosnippet_expand_or_jump)"
    elseif pumvisible()
        return "\<C-n>"
    else
        return "\<tab>"
    endif
endfunction

function! Zen_html_tab()
  if !emmet#isExpandable()
    return "\<plug>(emmet-move-next)"
  endif
  return "\<plug>(emmet-expand-abbr)"
endfunction

function! Openpluginrepo()
    try
        exec "normal! ".'"ayi'."'"
        exec 'OpenBrowser https://github.com/'.@a
    catch
        echohl WarningMsg | echomsg "can not open the web of current plugin" | echohl None
    endtry
endfunction

function! Helptab()
  if &buftype == 'help'
    wincmd T
    nnoremap <buffer> q :q<CR>
  endif
endfunction
