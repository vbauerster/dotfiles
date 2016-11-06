nnoremap <silent> <leader>gg :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gcc :Gcommit<CR>
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

" Every time you open a git object using fugitive it creates a new buffer.
" This means that your buffer listing can quickly become swamped with
" fugitive buffers. This prevents this from becomming an issue:
" augroup fug_buf_hide
"   autocmd!
"   autocmd BufReadPost fugitive://* set bufhidden=delete
" augroup END
