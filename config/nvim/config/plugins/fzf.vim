" https://github.com/junegunn/fzf/wiki/Examples-(vim)
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

if has('nvim') || has('gui_running')
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" function! s:gopath_handler(dir)
"   execute 'lcd $GOPATH/src/'.a:dir
"   execute 'FZF' . '$GOPATH/src/'.a:dir
"   if has("nvim")
"       call feedkeys('i')
"   endif
" endfunction

function! s:reglist()
  return [
    \     '": ' . @",
    \     '*: ' . @*,
    \     '+: ' . @+,
    \     '-: ' . @-,
    \     '0: ' . @0,
    \     '1: ' . @1,
    \     '2: ' . @2,
    \     '3: ' . @3,
    \     '4: ' . @4,
    \     '5: ' . @5,
    \     '6: ' . @6,
    \     '7: ' . @7,
    \     '8: ' . @8,
    \     '9: ' . @9,
    \     'a: ' . @a,
    \     'b: ' . @b,
    \     'c: ' . @c,
    \     'd: ' . @d,
    \     'e: ' . @e,
    \     'f: ' . @f,
    \     'g: ' . @g,
    \     'h: ' . @h,
    \     'i: ' . @i,
    \     'j: ' . @j,
    \     'k: ' . @k,
    \     'l: ' . @l,
    \     'm: ' . @m,
    \     'n: ' . @n,
    \     'o: ' . @o,
    \     'p: ' . @p,
    \     'q: ' . @q,
    \     'r: ' . @r,
    \     's: ' . @s,
    \     't: ' . @t,
    \     'u: ' . @u,
    \     'v: ' . @v,
    \     'w: ' . @w,
    \     'x: ' . @x,
    \     'y: ' . @y,
    \     'z: ' . @z
    \ ]
endfunction

function! s:regpaste(reg)
  let token = split(a:reg, ':')
  if len(token) > 1
      execute 'normal! "' . token[0] . 'p'
  endif
endfunction

function! s:change_branch(e)
  execute 'Git checkout' . a:e
endfunction

command! Gbranch call fzf#run({
    \ 'source': 'git branch',
    \ 'sink': function('<sid>change_branch'),
    \ 'left': 30
    \ })

command! FZFRegisters call fzf#run({
    \ 'source': <sid>reglist(),
    \ 'sink': function('<sid>regpaste'),
    \ 'options': '--reverse',
    \ 'right': '35%'
    \ })

" command! PlugDir call fzf#run({
"     \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
"     \ 'options': '--delimiter / --nth -1',
"     \ 'down':    '~40%',
"     \ 'sink':    'Explore'})

" command! FZFGopath call fzf#run({
"     \ 'source': "ls -1p $GOPATH/src | awk -F/ '/\\/$/ {print $1}'",
"     \ 'sink': function('<sid>gopath_handler'),
"     \ 'down': '50%'
"     \ })

command! FZFPlugConf call fzf#run(fzf#wrap({
    \ 'source': map(split(glob('~/.config/nvim/config/plugins/*.vim'), "\n"), 'fnamemodify(v:val, ":t")'),
    \ 'dir': '~/.config/nvim/config/plugins',
    \ 'options': '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
    \}))

" Show go source files that depends for the current package
" Same as :GoFiles but with fzf
command! -bang FZFGoDeps call fzf#run(fzf#wrap({
    \ 'source': go#tool#Deps(),
    \ 'down':    '40%',
    \}, <bang>0))

" Show go source files that depends for the current package
" Same as :GoFiles but with fzf
command! -bang FZFGoFiles call fzf#run(fzf#wrap({
    \ 'source': map(go#tool#Files(), 'fnamemodify(v:val, ":.")'),
    \ 'options': '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"',
    \ 'down':    '40%',
    \}, <bang>0))

" Show go test files
" Same as :GoFiles TestGoFiles XTestGoFiles but with fzf
command! -bang FZFTestGoFiles call fzf#run(fzf#wrap({
    \ 'source': map(go#tool#Files('TestGoFiles', 'XTestGoFiles'), 'fnamemodify(v:val, ":.")'),
    \ 'options': '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"',
    \ 'down':    '40%',
    \}, <bang>0))

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

" let g:fzf_tags_command = 'gtags -R --fields=+l --exclude=.git --exclude=node_modules --exclude=jspm_packages --exclude=log --exclude=tmp'

" Replace the default dictionary completion with fzf-based fuzzy completion
" sacrifice i_CTRL-d for something more usefull
" imap <expr> <c-d> fzf#vim#complete#word({'left': '15%'})

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
" Path completion using find (file + dir)
" imap <c-x><c-d> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
" File only completion using find
imap <c-x><c-f> <plug>(fzf-complete-file)
" Line completion (all open buffers)
" use i_CTRL-x_CTRL-l for built-in line completion
" also see h: cpt
imap <c-x><c-h> <plug>(fzf-complete-line)

nnoremap <Leader><F3> :Rg <C-R><C-W><CR>
xnoremap <Leader><F3> y:Rg <C-R>"<CR>

" avoids opening file in Nerd_tree window
nnoremap <silent> <expr> <Leader>- (expand('%') =~ 'NERD_tree' ? "\<C-w>w" : '').":Files\<cr>"
nnoremap <silent><Leader><Leader> :Buffers<CR>
nnoremap <silent><Leader>p. :GFiles?<CR>
nnoremap <silent><Leader>pf :GFiles<CR>
nnoremap <silent><Leader>pb :Gbranch<CR>
nnoremap <silent><Leader>pr :History<CR>
nnoremap <silent><Leader>ww :Windows<CR>
nnoremap <silent><Leader>mm :Commits<CR>
nnoremap <silent><Leader>bb :BCommits<CR>
" Swoop like
nnoremap <silent><Leader>ss :BLines<CR>
" Lines [QUERY] Lines in loaded buffers
nnoremap <silent><Leader>s* :Lines<CR>
nnoremap <silent><Leader>' :Marks<CR>
nnoremap <silent><Leader>; :History:<CR>
nnoremap <silent><Leader>/ :History/<CR>
" nnoremap <silent><Leader>pl :PlugDir<CR>
nnoremap <silent><Leader>yh :PlugHelp<CR>
nnoremap <silent><Leader>yc :FZFPlugConf<CR>
nnoremap <silent><Leader>yy :FZFRegisters<CR>
" nnoremap <silent><Leader>go :FZFGopath<CR>

nmap <Leader>nn <Plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))
