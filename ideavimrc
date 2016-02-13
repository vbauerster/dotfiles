let mapleader = ','
set ignorecase smartcase
set hlsearch
set showmode
set undolevels=100
set mps+=<:>
" switch between current and last buffer
"nmap <leader>. <C-^>
nnoremap <leader>. :action VimFilePrevious<cr>
nmap <leader>/ :nohlsearch<CR>
nmap <leader>cc :action CommentByLineComment<CR>
nmap <leader>rff :action ReformatCode<CR>
nmap <leader>, :action AceJumpAction<CR>
nmap <leader>q :action CloseContent<CR>
nmap csw' :action Macro.surround_with_single_quote<CR>
nmap csw" :action Macro.surround_with_double_quote<CR>
nmap ds' :action Macro.surround_undo_single_quote<CR>
nmap ds" :action Macro.surround_undo_double_quote<CR>
nmap cs"' :action Macro.surround_double_to_single_quote<CR>
" remove extra whitespace
nmap <leader><space> :%s/\s\+$<CR>
"nmap ,<space> :%s/\s\+$//e<CR>

nnoremap <leader>l :action EditorToggleShowWhitespaces<cr>

" easy system clipboard copy/paste
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p "*p
noremap <leader>P "*P

" unimpaired mappings
nnoremap [<space> O<esc>j
nnoremap ]<space> o<esc>k
nnoremap [q :action PreviousOccurence<cr>
nnoremap ]q :action NextOccurence<cr>
nnoremap [m :action MethodUp<cr>
nnoremap ]m :action MethodDown<cr>
nnoremap [c :action VcsShowPrevChangeMarker<cr>
nnoremap ]c :action VcsShowNextChangeMarker<cr>
