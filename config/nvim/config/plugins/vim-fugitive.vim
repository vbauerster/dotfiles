nnoremap <silent> <leader>gg :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gv :Gvsplit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" Git add %
nnoremap <silent> <leader>gw :Gwrite<CR>
" Git rm %
nnoremap <silent> <leader>gx :Gremove<CR>
" Git checkout %
nnoremap <silent> <leader>gu :Gread<CR>

au FileType gitcommit nnoremap <buffer> <silent> cn :<C-U>Gcommit --amend --date="$(date)"<CR>
