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

nmap <F11> <Plug>qf_loc_stay_toggle
nmap <F12> <Plug>qf_qf_stay_toggle
nmap <Leader><tab> <Plug>qf_qf_switch
nmap [x <Plug>qf_loc_previous
nmap ]x <Plug>qf_loc_next

" nnoremap <silent> <F11> :lcl<CR>
" nnoremap <silent> <F12> :ccl<CR>
