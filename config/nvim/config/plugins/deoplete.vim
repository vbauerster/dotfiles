" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" https://github.com/Shougo/deoplete.nvim/issues/267
" let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_camel_case = 1

" https://github.com/Shougo/deoplete.nvim/issues/288
call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" https://github.com/Shougo/deoplete.nvim/issues/150
call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#set('ultisnips', 'rank', 1000)

" imap     <Nul> <C-Space>
" inoremap <expr><C-Space> deoplete#mappings#manual_complete()

inoremap <expr><C-z> deoplete#undo_completion()

" instead of closing popup by <C-e>
inoremap <expr>- pumvisible() ? deoplete#close_popup() : "-"
