function! s:gopath_handler(dir)
  execute 'lcd $GOPATH/src/'.a:dir
  execute 'FZF' . '$GOPATH/src/'.a:dir
  if has("nvim")
      call feedkeys('i')
  endif
endfunction

function! s:yank_list()
  if exists(":Yanks")
    redir => ys
    silent Yanks
    redir END
    return split(ys, '\n')[1:]
  else
    return reverse(['0 ' . @0, '1 ' . @1, '2 ' . @2, '3 ' . @3, '4 ' . @4, '5 ' . @5, '6 ' . @6, '7 ' . @7, '8 ' . @8, '9 ' . @9])
  endif
endfunction

function! s:yank_handler(reg)
  if empty(a:reg)
    echo "aborted register paste"
  else
    let token = split(a:reg, ' ')
    if exists(":Yanks")
      execute 'Paste' . token[0]
    else
      execute 'normal! "' . token[0] . 'p'
    endif
  endif
endfunction

command! FZFYank call fzf#run({
      \ 'source': <sid>yank_list(),
      \ 'sink': function('<sid>yank_handler'),
      \ 'options': '-m',
      \ 'down': 12
      \ })

command! Plugs call fzf#run({
      \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
      \ 'options': '--delimiter / --nth -1',
      \ 'down':    '~40%',
      \ 'sink':    'Explore'})

command! FZFGopath call fzf#run({
      \ 'source': "ls -1p $GOPATH/src | awk -F/ '/\\/$/ {print $1}'",
      \ 'sink': function('<sid>gopath_handler'),
      \ 'options': '-m',
      \ 'down': '50%'
      \ })

command! FZFPlugConf call fzf#run(fzf#wrap({
      \ 'source': "ls -1 $DOTFILES/config/nvim/config/plugins",
      \ 'dir': "$DOTFILES/config/nvim/config/plugins",
      \ 'options': '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
      \}))

let $FZF_DEFAULT_OPTS .= ' --inline-info'

" let g:fzf_tags_command = 'gtags -R --fields=+l --exclude=.git --exclude=node_modules --exclude=jspm_packages --exclude=log --exclude=tmp'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Replace the default dictionary completion with fzf-based fuzzy completion
" inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
" sacrifice CTRL-d for something more usefull, read :help i_CTRL-d
imap <expr> <c-d> fzf#vim#complete#word({'left': '15%'})
" Line completion (all open buffers)
" imap <c-l> <plug>(fzf-complete-line)
" imap <c-x><c-f> <plug>(fzf-complete-file-ag)

nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
xnoremap <silent> <Leader>ag y:Ag <C-R>"<CR>

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options =
      \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" avoids opening file in Nerd_tree window
nnoremap <silent> <expr> <Leader>- (expand('%') =~ 'NERD_tree' ? "\<C-w>w" : '').":Files\<cr>"
nnoremap <silent><Leader>hh :History<CR>
nnoremap <silent><Leader>ww :Windows<CR>
nnoremap <silent><Leader><Leader> :Buffers<CR>
nnoremap <silent><Leader>gf :GitFiles<CR>
nnoremap <silent><Leader>mm :Commits<CR>
nnoremap <silent><Leader>bb :BCommits<CR>
nnoremap <silent><Leader>bl :BLines<CR>
nnoremap <silent><Leader>al :Lines<CR>
nnoremap <silent><Leader>' :Marks<CR>
nnoremap <silent><Leader>; :History:<CR>
nnoremap <silent><Leader>pp :Plugs<CR>
nnoremap <silent><Leader>pc :FZFPlugConf<CR>
nnoremap <silent><Leader>go :FZFGopath<CR>
nnoremap <silent><Leader>y :FZFYank<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
