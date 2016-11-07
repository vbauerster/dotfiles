" :h popupmenu-keys
" :h map-<expr>
let g:UltiSnipsExpandTrigger = "<c-s>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsSnippetsDir = $HOME . '/.config/nvim/UltiSnips'
let g:UltiSnipsEditSplit = "vertical"

nnoremap <silent> <Leader>es :UltiSnipsEdit<CR>
