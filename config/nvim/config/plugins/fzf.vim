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

function! s:change_branch(e)
  execute '!git checkout' . a:e
  :e!
endfunction

command! Gbranch call fzf#run({
      \ 'source': 'git branch',
      \ 'sink': function('<sid>change_branch'),
      \ 'left': 15
      \ })

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
      \ 'down': '50%'
      \ })

command! FZFPlugConf call fzf#run(fzf#wrap({
      \ 'source': "ls -1 $DOTFILES/config/nvim/config/plugins",
      \ 'dir': "$DOTFILES/config/nvim/config/plugins",
      \ 'options': '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
      \}))

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -g "!vendor" --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

if has('nvim')
	let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" let g:fzf_tags_command = 'gtags -R --fields=+l --exclude=.git --exclude=node_modules --exclude=jspm_packages --exclude=log --exclude=tmp'

" Replace the default dictionary completion with fzf-based fuzzy completion
" sacrifice i_CTRL-d for something more usefull
" imap <expr> <c-d> fzf#vim#complete#word({'left': '15%'})

" Path completion using find (file + dir)
imap <c-x><c-d> <plug>(fzf-complete-path)
" File only completion using find
imap <c-x><c-f> <plug>(fzf-complete-file)
" Line completion (all open buffers)
" use i_CTRL-x_CTRL-l for built-in line completion
" also see h: cpt
imap <c-x><c-h> <plug>(fzf-complete-line)

nnoremap <silent><F3> :Rg <C-R><C-W><CR>
xnoremap <silent><F3> y:Rg <C-R>"<CR>

" avoids opening file in Nerd_tree window
nnoremap <silent> <expr> <Leader>- (expand('%') =~ 'NERD_tree' ? "\<C-w>w" : '').":Files\<cr>"
nnoremap <silent><C-_> :GFiles<CR>
nnoremap <silent>g. :GFiles?<CR>
nnoremap <silent><Leader><Leader> :Buffers<CR>
" nnoremap <silent><Leader>hh :History<CR>
nnoremap <silent><Leader>hh :Windows<CR>
nnoremap <silent><Leader>mm :Commits<CR>
nnoremap <silent><Leader>bb :BCommits<CR>
" nnoremap <silent><Leader>bl :BLines<CR>
" Lines [QUERY] Lines in loaded buffers
nnoremap <silent><Leader>ll :Lines<CR>
nnoremap <silent><Leader>' :Marks<CR>
nnoremap <silent><Leader>; :History:<CR>
nnoremap <silent><Leader>/ :History/<CR>
nnoremap <silent><Leader>pp :Plugs<CR>
nnoremap <silent><Leader>pc :FZFPlugConf<CR>
nnoremap <silent><Leader>go :FZFGopath<CR>
nnoremap <silent><Leader>y :FZFYank<CR>

nmap <leader>nn <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)
