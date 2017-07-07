" <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
let g:AutoPairsMapCR = 0
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-x>'
" let g:AutoPairsShortcutFastWrap = '<M-w>'

" https://github.com/jiangmiao/auto-pairs/issues/91
imap <expr><CR> pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>\<Plug>AutoPairsReturn"
