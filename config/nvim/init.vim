" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" VIM-PLUG BLOCK {{{
  " Install Plug -> faster
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif

  " https://github.com/junegunn/vim-plug
  source ~/.config/nvim/config/plugs.vim
"}}}

" termcolors {{{
  " source ~/.config/nvim/config/termcolors.vim
"}}}

" abbr {{{
  source ~/.config/nvim/config/abbr.vim
"}}}

" Script local functions {{{

" Set tabstop, softtabstop and shiftwidth to the same value
" http://vimcasts.org/episodes/tabs-and-spaces
  command! -nargs=* Stab call Stab()
  function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
      let &l:sts = l:tabstop
      let &l:ts = l:tabstop
      let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
  endfunction

  function! SummarizeTabs()
    try
      echohl ModeMsg
      echon "\r"
      echon 'tabstop='.&l:ts
      echon ' shiftwidth='.&l:sw
      echon ' softtabstop='.&l:sts
      if &l:et
        echon ' expandtab'
      else
        echon ' noexpandtab'
      endif
    finally
      echohl None
    endtry
  endfunction

  function! s:HelpTab()
    if &buftype ==# "help"
      wincmd T
      nnoremap <buffer> q :q<CR>
    endif
  endfunction

  function! s:deleteParam()
    let line = getline('.')
    let bc = col('.')-2
    let i = bc
    while i >= 0 && line[i] !~ '[ ,(]'
      let i -= 1
    endwhile
    if len(split(line[i:], ",")) > 1
      let op = "df,"
      return bc - i == 0 ? op : bc - i . "h" . op
    else
      let op = "dt)"
      return bc - i == 0 ? op : bc - i . "h" . op
    endif
  endfunction

  " Original: https://github.com/justinmk/config/blob/347aecb4f74dc755e000c97eae17d80598c80d42/.config/nvim/init.vim#L272-L289
  " vim-vertical-move replacement
  " credit: cherryberryterry: https://www.reddit.com/r/vim/comments/4j4duz/a/d33s213
  function! s:vjump(dir)
      let c = '%'.virtcol('.').'v'
      let flags = a:dir ? 'bnW' : 'nW'
      let bot = search('\v'.c.'.*\n^(.*'.c.'.)@!.*$', flags)
      let top = search('\v^(.*'.c.'.)@!.*$\n.*\zs'.c, flags)
      echom string(bot) string(top)

      " norm! m`
      return a:dir ? (line('.') - (bot > top ? bot : top)).'k'
        \   : ((bot < top ? bot : top) - line('.')).'j'
  endfunction
  nnoremap <expr> <C-j> <SID>vjump(0)
  nnoremap <expr> <C-k> <SID>vjump(1)
  xnoremap <expr> <C-j> <SID>vjump(0)
  xnoremap <expr> <C-k> <SID>vjump(1)
  onoremap <expr> <C-j> <SID>vjump(0)
  onoremap <expr> <C-k> <SID>vjump(1)
"}}}

" COLORSCHEME {{{
  execute "set background=".$BACKGROUND

  " colorscheme materialbox
  " let g:materialbox_contrast_light="hard"
  " let g:materialbox_italic=1
  " let g:materialbox_italicize_comments=1

  let g:gruvbox_contrast_light="hard"
  let g:gruvbox_contrast_dark="soft"
  let g:gruvbox_italic=1
  " https://github.com/morhetz/gruvbox/wiki/Configuration
  let g:gruvbox_italicize_comments=1
  let g:gruvbox_italicize_strings=0
  let g:gruvbox_invert_selection=1
  let g:gruvbox_invert_signs=0
  let g:gruvbox_invert_indent_guides=0
  let g:gruvbox_invert_tabline=0
  let g:gruvbox_improved_strings=0
  let g:gruvbox_improved_warnings=1
  colorscheme gruvbox
  nnoremap <silent> com :call gruvbox#invert_signs_toggle()<cr>

  " let g:one_allow_italics = 1
  " colorscheme one
  " call one#highlight('function', '', '', 'bold,italic')

  " Find out to which highlight-group a particular keyword/symbol belongs
  command! Wcolor echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
            \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") .
            \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .
            \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")
"}}}

" BASIC SETTINGS {{{
  let mapleader = ' '
  " let maplocalleader = ' '

  " let g:python_host_prog = "/usr/local/bin/python2"
  " let g:python3_host_prog = "/usr/local/bin/python3"

  " https://github.com/neovim/neovim/pull/4690
  set termguicolors

  " see :help 'guicursor'
  " let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  " https://github.com/neovim/neovim/wiki/Following-HEAD#20170403
  set mouse=a

  " Excluding version control directories
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
  " OS X
  if has('mac')
    set wildignore+=*.DS_Store
  endif
  " Binary images
  set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

  set number
  set timeoutlen=600                   " mapping timeout
  set ttimeoutlen=50                   " keycode timeout
  set dictionary=/usr/share/dict/words " :h i_CTRL-x_CTRL-k
  set wildmode=list:longest            " TAB auto-completion for file paths
  set hidden                           " current buffer can be put into background
  set showcmd                          " show incomplete commands
  set noshowmode                       " don't show which mode disabled for PowerLine
  set scrolloff=2                      " lines of text around cursor
  " set foldlevelstart=99                " all folds open by default
  set foldmethod=syntax
  set cmdheight=1                      " command bar height
  set complete=.,w,t                   " :h cpt
  set completeopt=menuone,noselect     " :h cot
  set noerrorbells

  " SPACES & TABS
  " Explanations from http://tedlogan.com/techblog3.html
  set tabstop=4     " How many columns a tab counts for
  set softtabstop=4 " insert mode behaviour of TAB and BS
  set shiftwidth=0  " When zero the 'ts' value will be used
  set expandtab     " Use spaces
  set smartindent   " Normally 'autoindent' should also be on when using 'smartindent'
  set ruler         " show the cursor position all the time
  set nojoinspaces  " Prevents inserting two spaces after punctuation on a join (J)

  " set linebreak
  " set nowrap

  " Searching
  set gdefault         " global search by default
  set ignorecase       " case insensitive searching
  set smartcase        " case-sensitive if expresson contains a capital letter
  set lazyredraw       " don't redraw while executing macros
  set inccommand=split " incremental live substitute

  " Highlight current line
  " http://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim
  set cursorline

  set textwidth=80
  " if textwidth > 80 highlight overlength with reddish bg
  " highlight OverLength ctermbg=223 guibg=#FDEEF4
  " match OverLength /\%81v.\+/

  " Set spellfile to location that is guaranteed to exist, can be symlinked to
  " Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
  " set spellfile=$HOME/.vim-spell-en.utf-8.add

  " Open new split panes to right and bottom, which feels more natural
  " https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
  " set splitbelow
  " set splitright

  " Always use vertical diffs
  set diffopt+=vertical

  " For conceal markers.
  " if has('conceal')
  "   set conceallevel=2 concealcursor=niv
  " endif

  " Whitespaces
  set list
  set listchars=tab:›⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
  " set listchars=tab:¦\ ,trail:⋅,extends:❯,precedes:❮
  " set listchars=tab:│\ ,trail:⋅,extends:❯,precedes:❮
  set showbreak=↪

  set noswapfile
"}}}

" MAPPINGS {{{
  " open vimrc
  nnoremap <Leader>ev <C-w><C-v><C-l>:e ~/dotfiles/config/nvim/init.vim<CR>
  " reload vimrc
  nnoremap <Leader>rs :source $MYVIMRC<CR>
  " edit vim plugins
  nnoremap <Leader>ep :e ~/dotfiles/config/nvim/config/plugs.vim<CR>
  " edit gitconfig
  nnoremap <Leader>eg :e ~/dotfiles/gitconfig<CR>
  " edit tmux.conf
  nnoremap <Leader>et :e ~/dotfiles/tmux/tmux.conf<CR>
  " edit zshrc
  nnoremap <Leader>ez :e ~/dotfiles/zshrc<CR>
  " edit/view log from wi-fi box
  " nnoremap <Leader>ewm :e scp://root@192.168.2.1//var/log/messages<CR>
  " nnoremap <Leader>ewu :e scp://root@192.168.2.1//jffs/runblock/runblock.dnsmasq<CR>

  " set working directory to the current buffer's directory
  nnoremap cd :lcd %:p:h<BAR>pwd<CR>
  nnoremap cu :lcd ..<BAR>pwd<CR>
  nnoremap cD :cd %:p:h<BAR>pwd<CR>
  nnoremap cU :cd ..<BAR>pwd<CR>
  nnoremap <leader>pp :pwd<CR>

  " In normal mode, we use : much more often than ; so lets swap them.
  " WARNING: this will cause any "ordinary" map command without the "nore" prefix
  " that uses ":" to fail. For instance, "map <f2> :w" would fail, since vim will
  " read ":w" as ";w" because of the below remappings. Use "noremap"s in such
  " situations and you'll be fine.
  " https://github.com/junegunn/fzf.vim/issues/313
  " nnoremap ; :
  " xnoremap ; :

  nnoremap ' `

  " reselect last paste
  nnoremap gp '[V']

  " переместить одну строку
  nnoremap <S-Home> ddkP
  nnoremap <S-End> ddp
  " переместить несколько выделенных строк http://www.vim.org/scripts/script.php?script_id=1590
  vnoremap <S-Home> xkP'[V']
  vnoremap <S-End> xp'[V']

  " don't override enter behavior in quickfix/location windows
  nnoremap <expr> <Enter> (&buftype is# "quickfix" ? "\<cr>" : "%")

  " tab shortcuts
  " Tab and Shift-Tab switches opened tabs in normal mode
  " nnoremap <Tab> gt
  " nnoremap <S-Tab> gT
  nnoremap g} gt
  nnoremap g{ gT
  nnoremap <Leader>tn :tabnew<CR>
  nnoremap <Leader>tc :tabclose<CR>
  nnoremap <Leader>to :tabonly<CR>

  " Go to last active tab
  " https://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim#2120168
  " https://superuser.com/questions/410982/in-vim-how-can-i-quickly-switch-between-tabs
  au TabLeave * let g:lasttab = tabpagenr()
  nnoremap <Leader><Tab> :exe "tabn ".g:lasttab<CR>

  " Quit nvim
  " nnoremap <Leader>q :q<CR>
  " nnoremap <Leader>!! :qa!<CR>
  " buffer delete
  nnoremap <Leader><F10> :bd<CR>

  " F1 will search help for the word under the cursor
  nnoremap <Leader><F1> :help <C-r><C-w><CR>

  " Save in normal mode
  nnoremap <Leader><F2> :up<CR>

  " Buffer reload
  nnoremap <Leader><F5> :e!<CR>

  " Read :help ctrl-w_w
  " Read :help wincmd
  "  <C-w>q
  "  <C-w>w
  "  <C-w>W
  "  <C-w>p Go to previous (last accessed) window
  "  <C-w>P Go to preview window
  "  <C-w>z Close any 'Preview' window currently open
  "  <C-w>c Close the current window
  "  <C-w>T Move the current window to a new tab page
  " nnoremap <C-W>n <C-w>l
  " nnoremap <C-W>l <C-w>n
  " nnoremap <C-W>N <C-w>L
  " nnoremap <C-W>L <C-w>N

  " quick access to yank reg
  noremap "" "0
  " make Y consistent with C and D. See :help Y.
  nnoremap Y y$
  " copy selection to gui-clipboard
  xnoremap Y "*y
  " copy entire file contents (to gui-clipboard if available)
  " mnemomic: global yank
  nnoremap gy :let b:winview=winsaveview()<bar>exe 'keepjumps keepmarks norm ggVG'.(has('clipboard')?'"*y':'y')<bar>call winrestview(b:winview)<cr>
  " copy full path into clipboard if available otherwise into unnamed register (" and 0)
  " https://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
  " just filename :let @+ = expand("%:t")
  " also see :h filename-modifiers
  nnoremap <silent> cp* :exe ':let '.(has('clipboard')?'@*':'@"').'=expand("%:p")'<cr>
        \ :echon '"'expand("%:p")'" copied into 'has('clipboard')?'*':'"' 'register'<cr>
  nnoremap <silent> cpp :let @" = expand("%:.")<cr>
  nnoremap <silent> cpn :let @" = expand("%:.") . ":" . line(".")<cr>

  " Search in normal mode with very magic on
  " nnoremap / /\v
  " nnoremap ? ?\v

  " This makes j and k work on 'screen lines' instead of on 'file lines'; now, when
  " we have a long line that wraps to multiple screen lines, j and k behave as we
  " expect them to.
  nnoremap j gj
  nnoremap k gk
  " nnoremap ^ g^
  " nnoremap $ g$

  nnoremap '+ z+
  nnoremap '- z-

  " noremap + 6gj
  " noremap <M-+> 6gk

  " auto center
  nnoremap <silent> n nzz
  nnoremap <silent> N Nzz
  nnoremap <silent> * *zz
  nnoremap <silent> # #zz
  nnoremap <silent> g* g*zz
  nnoremap <silent> g# g#zz

  " fold a html tag
  " nnoremap <Leader>ft Vatzf
  nnoremap <Leader>ft zfat
  nnoremap <Leader>fb zfaB

  " Wipe xxx {} block
  nnoremap <Leader>xB vaBo0d
  nnoremap <expr><Leader>xp <SID>deleteParam()

  " Read :help g_ctrl-]
  " same as :tjump
  " jump to tag if there's only one matching tag, but show list of
  " options when there is more than one definition
  nnoremap <C-]> g<C-]>
  " prefer :ptjump to :ptag
  " nnoremap <C-w>} <C-w>g}

  " Remove trailing whitespaces
  " nnoremap <silent><Leader>wx :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

  " switch between buffers
  nnoremap <silent>,. <C-^><CR>

  " http://habrahabr.ru/post/183222/
  " spell toggle
  nnoremap <Leader>sp :setlocal spell! spelllang=ru_yo,en_us<CR>
  " spell check off
  " nnoremap <Leader>spp :setlocal spell spelllang=<ENTER>

  nnoremap <silent><Leader>sc :call clearmatches()<CR>:noh<CR>

  " -----------------------------------------------------------
  " => Diff3 merge
  " -----------------------------------------------------------
  nnoremap <silent><Leader>dl :diffget LOCAL \| diffupdate<CR>
  nnoremap <silent><Leader>dr :diffget REMOTE \| diffupdate<CR>

  " -----------------------------------------------------------
  " => h: window-resize
  " -----------------------------------------------------------
  " nnoremap <Leader>= <C-w>=
  nnoremap <silent> <Leader>= :wincmd =<cr>:QfResizeWindows<cr>
  nnoremap <Leader>z <C-w><Bar><C-w>_
  nnoremap <Leader>o <C-w>o
  nnoremap <Leader>v <C-w>v
  " nnoremap <Leader>x <C-w>s

  " http://stackoverflow.com/questions/1262154/minimizing-vertical-vim-window-splits
  " z{nr}<CR>  Set current window height to {nr}.
  " set winminheight=0
  " nmap <Leader>k <C-W>j<C-W>_
  " nmap <Leader>j <C-W>k<C-W>_

  " set winminwidth=0
  " nmap <Leader>l <C-W>h500<C-W>>
  " nmap <Leader>h <C-W>l500<C-W>>

  nnoremap <M-Left> <C-w><
  nnoremap <M-Right> <C-w>>
  nnoremap <M-Up> <C-w>+
  nnoremap <M-Down> <C-w>-

  " -----------------------------------------------------------
  " => search related
  " -----------------------------------------------------------
  " nmap <Leader>* ]I
  " nmap <Leader># [I

  " <leader>ff shows list for relative jump
  nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

  " find current word in quickfix
  " nnoremap <Leader>g* :execute "vimgrep ".expand("<cword>")." %"<CR>:copen<CR><C-w>W
  " find last search in quickfix
  " nnoremap <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR><C-w>W

  " buf-search (shift + F3)
  " nnoremap <F15> :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

  " -----------------------------------------------------------
  " => External cmd mappings
  " -----------------------------------------------------------
  " http://stackoverflow.com/questions/3166413/execute-a-script-directly-within-vim-mvim-gvim
  " nnoremap <Leader>nh :write !node --harmony<CR>

  " make tags, --fields=+l needs by YCM
  " http://stackoverflow.com/questions/25819649/exuberant-ctags-exclude-directories#25819720
  " http://raygrasso.com/posts/2015/04/using-ctags-on-modern-javascript.html
  " nnoremap <Leader>mt :!gtags -R --fields=+l --exclude=.git --exclude=node_modules --exclude=jspm_packages --exclude=log --exclude=tmp *<CR><CR>

  " -----------------------------------------------------------
  " => Insert mode mappings
  " -----------------------------------------------------------
  " Start new line
  " inoremap <S-Return> <C-o>o

  " imap <F11> <C-o><F11>

  " insert absolute current buffer path
  " inoremap <F4> <C-R>=expand('%:p')<CR>

  " quick movements
  " http://vim.wikia.com/wiki/Quick_command_in_insert_mode
  inoremap II <Esc>I
  inoremap AA <Esc>A
  " CTRL-\ CTRL-O like CTRL-O but don't move the cursor [i_CTRL-\_CTRL-O]
  inoremap CC <C-\><C-o>D

  " upper case
  inoremap UU <Esc>gUiw`]a

  " imap <Nul> <C-Space>
  " inoremap <C-Space> <C-x><C-l>

  inoremap <expr> <c-t> pumvisible() ? "\<c-p>" : "\<c-t>"
  " inoremap <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
  " inoremap <expr> <c-h> pumvisible() ? "\<c-y>" : "\<c-h>"

  " http://superuser.com/a/1165038/578741
  inoremap <F2> <C-\><C-o>:w<CR>
  inoremap <silent> ,. <Esc>:up<CR>

  " inoremap <insert> <C-r>*

  " -----------------------------------------------------------
  " => Visual and Select mode mappings
  " -----------------------------------------------------------
  " vnoremap ,. <Esc>

  " Search in visually selected block only
  vnoremap / <Esc>/\%V\v
  vnoremap ? <Esc>?\%V\v

  " With this map, we can select some text in visual mode and by invoking the map,
  " have the selection automatically filled in as the search text and the cursor
  " placed in the position for typing the replacement text. Also, this will ask
  " for confirmation before it replaces any instance of the search text in the
  " file.
  " NOTE: We're using %S here instead of %s; the capital S version comes from the
  " eregex.vim plugin and uses Perl-style regular expressions.
  vnoremap <C-r> "hy:%s/<C-r>h//c<left><left>

  " Select blocks after indenting
  xnoremap < <gv
  xnoremap > >gv

  " -----------------------------------------------------------
  " => Command mode mappings
  " -----------------------------------------------------------
  " refer to the directory of the current file, regardless of pwd
  cnoremap %% <C-R>=expand('%:h').'/'<CR>
  " quick save (h with strong index finger)
  " cnoremap ;h <C-u>w<CR>
  " quick pwd
  " cnoremap ;d <C-u>pwd<CR>
  " cnoremap c} <C-u>pwd<CR>
  " Quit all without save, also refer to line 187
  " cnoremap !; <C-u>qa!<CR>
  cnoremap >> <C-u>qa!<CR>

  cnoremap <C-A> <Home>
  cnoremap <C-O> <Up>

  " -----------------------------------------------------------
  " => Terminal mode mappings
  " -----------------------------------------------------------
  " Start terminal
  nnoremap <silent><leader>ts <C-w>v:te<CR>
  nnoremap <silent><leader>th <C-w>s<C-w>J8<C-w>-:te<CR>
  " resize terminal horizontally
  " nnoremap <expr><Up> &buftype ==# "terminal" ? "\<C-w>+<CR>" : "\<Up>"
  " nnoremap <expr><Down> &buftype ==# "terminal" ? "\<C-w>-<CR>" : "\<Down>"

  " Read :help nvim-terminal-emulator
  " <C-\><C-n> key combo, exit back to normal mode.
  tnoremap ,. <C-\><C-n>
  tmap <C-k> ,.<C-k>
  tmap <C-j> ,.<C-j>
  tmap <C-h> ,.<C-h>
  tmap <C-l> ,.<C-l>
  tmap <C-\> ,.<C-\>
  tmap <C-w> ,.<C-w>
"}}}

" AUTOCMD {{{
  augroup Vimrc_au
    au!

    " Remove trailing whitespaces
    au BufWritePre * :%s/\s\+$//e

    " Help in new tabs
    au BufEnter *.txt call <sid>HelpTab()

    " highlight cursorline in active window
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline

    " Create directory if not exists
    au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    " :h last-position-jump
    au BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \  exe 'normal! g`"zvzz' |
          \ endif

    " Unset paste on InsertLeave
    " au InsertLeave * silent! set nopaste
  augroup END

  augroup FileType_au
    au!
    au FileType sh,xml,html,javascript   setl ts=2 sts=2 sw=2 et
    au FileType py,markdown              setl ts=4 sts=4 sw=4 et
    au FileType go                       setl ts=4 sts=4 sw=4 noet
    au FileType markdown,gitcommit       setl spell spelllang=ru_yo,en_us
    au FileType gitcommit                setl textwidth=72
    au FileType markdown                 setl textwidth=80

    " autocmd FileType json setlocal conceallevel&
    " https://stackoverflow.com/a/20127451/1351845
    au FileType json       setl equalprg=js-beautify\ -
    au FileType javascript setl equalprg=js-beautify\ -
  augroup END

  " augroup Tmux_au
  "   autocmd!
  "   if exists('$TMUX') && !exists('$NORENAME')
  "     autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
  "     autocmd VimLeave * call system('tmux set-window automatic-rename on')
  "   endif
  " augroup END

  augroup Terminal_au
    au!
    au TermOpen * :setl nonumber
    au TermOpen * startinsert
    au WinEnter term://* startinsert
    " autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    " https://github.com/junegunn/fzf.vim/issues/21
    " https://github.com/junegunn/fzf/issues/426
    " autocmd BufWinEnter,WinEnter term://* startinsert
    " autocmd BufWinEnter,WinEnter term://* call feedkeys('i')
    " autocmd BufWinEnter,WinEnter term://* echom string(reltime())
  augroup END
"}}}

" plugin settings BLOCK {{{
  " Load plugin specific settings
  for f in split(glob('~/.config/nvim/config/plugins/*.vim'), "\n") | execute 'source ' . fnameescape(f) | endfor
"}}}
