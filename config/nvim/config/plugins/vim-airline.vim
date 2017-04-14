" For powerline enabled font.
" let g:airline_powerline_fonts = 1

let g:airline_inactive_collapse = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#windowswap#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

" Themes are automatically selected based on the matching colorscheme.
" this can be overridden by defining a value:
"     let g:airline_theme='dark'
" See `:echo g:airline_theme_map` for some more choices

if !exists('g:airline_powerline_fonts')
  " Use the default set of separators with a few customizations
  let g:airline_left_sep='›'  " Slightly fancier than '>'
  let g:airline_right_sep='‹' " Slightly fancier than '<'
endif
