let g:qf_mapping_ack_style = 1

" https://github.com/romainl/vim-qf/issues/44
" https://github.com/romainl/vim-qf/pull/48
" https://github.com/neomake/neomake/issues/1097#issuecomment-298780826
let g:qf_auto_open_loclist = 0
let g:qf_auto_open_quickfix = 0
" disable auto resize, let vim-qf_resize plugin manage it
let g:qf_auto_resize = 0
" let g:qf_loclist_window_bottom = 0
" let g:qf_window_bottom = 0

nmap <Leader>cc <Plug>(qf_loc_toggle_stay)
nmap <Leader>cq <Plug>(qf_qf_toggle_stay)
nmap <Leader>cw <Plug>(qf_qf_switch)
nmap [. <Plug>(qf_loc_previous)
nmap ].  <Plug>(qf_loc_next)

" nnoremap <silent> <F11> :lcl<CR>
" nnoremap <silent> <F12> :ccl<CR>
