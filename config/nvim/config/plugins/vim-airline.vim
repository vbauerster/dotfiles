" For powerline enabled font.
let g:airline_powerline_fonts = 1

" Smarter tab line
let g:airline#extensions#tabline#enabled = 1

let g:airline_inactive_collapse = 1

" Themes are automatically selected based on the matching colorscheme.
" this can be overridden by defining a value:
"     let g:airline_theme='dark'
" See `:echo g:airline_theme_map` for some more choices

if !exists('g:airline_powerline_fonts')
  " Use the default set of separators with a few customizations
  let g:airline_left_sep='›'  " Slightly fancier than '>'
  let g:airline_right_sep='‹' " Slightly fancier than '<'
endif
