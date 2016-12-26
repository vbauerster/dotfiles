" :h popupmenu-keys
" :h map-<expr>
let g:UltiSnipsExpandTrigger = "<C-s>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsSnippetsDir = $DOTFILES . '/config/nvim/UltiSnips'
let g:UltiSnipsEditSplit = "vertical"

nnoremap <silent> <Leader>eu :UltiSnipsEdit<CR>
