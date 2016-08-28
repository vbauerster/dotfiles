" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

" https://github.com/junegunn/vim-plug
source ~/.config/nvim/nvimrc.plug

" }}}
" ============================================================================
" Script local functions {{{
" ============================================================================

function! s:HelpTab()
  if &buftype ==# "help"
    wincmd T
    nnoremap <buffer> q :q<CR>
  endif
endfunction

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

let mapleader = ' '
let maplocalleader = ' '

execute "set background=".$BACKGROUND
if $BACKGROUND == 'dark'
  let g:gruvbox_contrast_dark='soft'
endif
colorscheme gruvbox

" https://github.com/neovim/neovim/pull/4690
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

source ~/.config/nvim/termcolors.vim

" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" OS X
set wildignore+=*.DS_Store
" Binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

set timeoutlen=500                   " mapping timeout
set ttimeoutlen=50                   " keycode timeout
set number
set dictionary=/usr/share/dict/words " CTRL-X CTRL-K to autocomplete
set wildmode=list:longest            " TAB auto-completion for file paths
set hidden                           " current buffer can be put into background
set showcmd                          " show incomplete commands
set noshowmode                       " don't show which mode disabled for PowerLine
set scrolloff=2                      " lines of text around cursor
set foldlevelstart=99                " all folds open by default
set cmdheight=1                      " command bar height
set noerrorbells
set complete=.,w,t
set completeopt=menu,noselect,longest
" noinsert adds auto select feature to deoplete
" set completeopt=menu,noselect,noinsert

" SPACES & TABS
" Explanations from http://tedlogan.com/techblog3.html
set tabstop=2     " How many columns a tab counts for
set softtabstop=2 " How many columns vim uses when pressing TAB in insert mode
set shiftwidth=2  " How many columns text is indented with << and >>
set expandtab     " Use spaces
set smartindent   " Normally 'autoindent' should also be on when using 'smartindent'
set ruler         " show the cursor position all the time
set nojoinspaces  " Prevents inserting two spaces after punctuation on a join (J)

" Searching
set gdefault   " global search by default
set ignorecase " case insensitive searching
set smartcase  " case-sensitive if expresson contains a capital letter
set lazyredraw " don't redraw while executing macros

" Highlight current line
" http://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim
set cursorline

set textwidth=80
" if textwidth > 80 highlight overlength with reddish bg
" highlight OverLength ctermbg=223 guibg=#592929
" match OverLength /\%81v.\+/

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
" set spellfile=$HOME/.vim-spell-en.utf-8.add

" Open new split panes to right and bottom, which feels more natural
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Whitespaces
set list " col to toggle
set listchars=tab:›⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
" set showbreak=↪

" backup/persistance settings
" set undodir=~/.vim/tmp/undo//
" set backupdir=~/.vim/tmp/backup//
" set directory=~/.vim/tmp/swap//
" set backupskip=/tmp/*,/private/tmp/*"
" set backup " delete old backup, backup current file
" set undofile
set noswapfile

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================
" open vimrc
nnoremap <Leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" edit vim plugins
nnoremap <Leader>ep :e ~/.config/nvim/nvimrc.plug<CR>
" edit vim local
nnoremap <Leader>el :e ~/.config/nvim/nvimrc.local<CR>
" edit gitconfig
nnoremap <Leader>eg :e ~/.gitconfig<CR>
" edit tmux.conf
nnoremap <Leader>et :e ~/.tmux.conf<CR>
" edit zshrc
nnoremap <Leader>ez :e ~/.zshrc<CR>
" edit/view log from wi-fi box
nnoremap <Leader>ewm :e scp://root@192.168.2.1//var/log/messages<CR>
nnoremap <Leader>ewu :e scp://root@192.168.2.1//jffs/runblock/runblock.dnsmasq<CR>

" In normal mode, we use : much more often than ; so lets swap them.
" WARNING: this will cause any "ordinary" map command without the "nore" prefix
" that uses ":" to fail. For instance, "map <f2> :w" would fail, since vim will
" read ":w" as ";w" because of the below remappings. Use "noremap"s in such
" situations and you'll be fine.
noremap ; :

" Swap implementations of ` and ' jump to markers
nnoremap ' `
nnoremap ` '

" quickly access yank reg
noremap "" "0

nmap <Enter> %

" F1 will search help for the word under the cursor
nnoremap <F1> :help <C-r><C-w><CR>

" tab shortcuts
nnoremap - gT
nnoremap + gt
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>
" Save
nnoremap <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>

" w!! to sudo write
" use :SudoWrite from vim-eunuch
" cmap w!! w !sudo tee % >/dev/null<CR>

" Quit
nnoremap <silent> <F10> :q<CR>
nnoremap <Leader>! :q!<CR>
nnoremap <silent> <Leader>x :close<CR>

" Enter visual line mode
" nmap <Leader><leader> V

" Read :help ctrl-w_w
" Read :help wincmd
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
" Go to previous (last accessed) window
" nnoremap <Leader><Tab> <C-w>p

" make Y consistent with C and D. See :help Y.
nnoremap Y y$

" <C-w> c Close the current window
" <C-w> z Close any "Preview" window currently open
" <C-w> P Go to preview window

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" reselect last paste
nnoremap gp `[v`]

" Search in normal mode with very magic on
nnoremap / /\v
nnoremap ? ?\v
" Search in visually selected block only
vnoremap / <Esc>/\%V\v
vnoremap ? <Esc>?\%V\v

vmap <Leader>s :sort<CR>

" paste multiple lines multiple times
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

noremap <silent> gj 4gj
noremap <silent> gk 4gk

" auto center
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" fold a html tag
nnoremap <Leader>ft Vatzf

" Read :help g_ctrl-]
" same as :tjump
" jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <c-]> g<c-]>

" Switch to the directory of the open buffer
nnoremap <silent><Leader>cd :cd %:p:h<CR>

" Remove spaces at the end of lines
nnoremap <silent><Leader>w<Leader> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" Buffer reload
nnoremap <Leader>rr :e!<CR>

" switch between buffers
" bprev provided by unimpaired [b
" bnext provided by unimpaired ]b
nnoremap <silent><Leader>. <C-^><CR>
nnoremap <Leader>bx :bd<CR>

nnoremap <Leader>v <C-w>v

" Show Registers
nnoremap <Leader>di :di<CR>

" http://habrahabr.ru/post/183222/
" spell toggle
nnoremap <Leader>sp :setlocal spell! spelllang=ru_yo,en_us<CR>
" spell check off
" nnoremap <Leader>spp :setlocal spell spelllang=<ENTER>

" toggle search highlighting: coh by unimpaired
" nnoremap <silent><Leader>/ :set invhlsearch<CR>
nnoremap <Leader>hi :Highlight<CR>
nnoremap <silent><C-c> :call clearmatches()<CR>:noh<CR>

" https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
" After applying above fix, below line is no longer necessary
" nnoremap <silent> <BS> :TmuxNavigateLeft<CR>

" Start terminal
nnoremap <Leader>tv <C-w>v:te<CR>
nnoremap <Leader>te <C-w>s<C-w>J8<C-w>-:te<CR>
" resize terminal horizontally
nnoremap <expr><Up> &buftype ==# "terminal" ? "\<C-w>+<CR>" : "\<Up>"
nnoremap <expr><Down> &buftype ==# "terminal" ? "\<C-w>-<CR>" : "\<Down>"

" -----------------------------------------------------------
" => h: window-resize
" -----------------------------------------------------------
" nnoremap <Leader>z :wincmd _<CR>:wincmd \|<CR>
nnoremap <silent><Leader>- :wincmd =<CR>

" http://stackoverflow.com/questions/1262154/minimizing-vertical-vim-window-splits
" z{nr}<CR>  Set current window height to {nr}. 
set winminheight=0
nmap <Leader>k <C-W>j<C-W>_
nmap <Leader>j <C-W>k<C-W>_

set winminwidth=0
nmap <Leader>l <C-W>h500<C-W>>
nmap <Leader>h <C-W>l500<C-W>>

nnoremap <M-Left> <C-w>>
nnoremap <M-Right> <C-w><
nnoremap <M-Up> <C-w>+
nnoremap <M-Down> <C-w>-

" -----------------------------------------------------------
" => Terminal mode mappings
" -----------------------------------------------------------
" Read :help nvim-terminal-emulator
" <C-\><C-n> key combo, exit back to normal mode.
tnoremap hh <C-\><C-n>
tmap <C-k> hh<C-k>
tmap <C-j> hh<C-j>
tmap <C-h> hh<C-h>
tmap <C-l> hh<C-l>
tmap <C-\> hh<C-\>
tmap <S-Tab> hh<C-w>p

" -----------------------------------------------------------
" => Command mode mappings
" -----------------------------------------------------------
" refer to the directory of the current file, regardless of pwd
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" -----------------------------------------------------------
" => Insert mode mappings
" -----------------------------------------------------------
" Start new line
inoremap <S-Return> <C-o>o

" insert absolute current buffer path
inoremap <F2> <C-R>=expand('%:p')<CR>

" quick movements
" http://vim.wikia.com/wiki/Quick_command_in_insert_mode
inoremap II <Esc>I
inoremap AA <Esc>A
" <C-\> does not eat last char of the line
inoremap CC <C-\><C-O>D
inoremap hh <Esc>

" upper case
inoremap UU <Esc>gUiw`]a

imap     <Nul> <C-Space>
inoremap <C-Space> <C-x><C-l>

" -----------------------------------------------------------
" => vimgrep
" -----------------------------------------------------------
nnoremap <Leader>* [I
" find current word in quickfix
nnoremap <Leader>** :execute "vimgrep ".expand("<cword>")." %"<CR>
" find last search in quickfix
nnoremap <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>

" -----------------------------------------------------------
" => External cmd mappings
" -----------------------------------------------------------
" http://stackoverflow.com/questions/3166413/execute-a-script-directly-within-vim-mvim-gvim
nnoremap <Leader>nh :write !node --harmony<CR>
" see ':h :!'; '.' stands for concatination
nnoremap <Leader>nn :exe "!babel-node " . shellescape(expand("%"))<CR>

" make tags, --fields=+l needs by YCM
" http://stackoverflow.com/questions/25819649/exuberant-ctags-exclude-directories#25819720
" http://raygrasso.com/posts/2015/04/using-ctags-on-modern-javascript.html
nnoremap <Leader>mt :!gtags -R --fields=+l --exclude=.git --exclude=node_modules --exclude=jspm_packages --exclude=log --exclude=tmp *<CR><CR>

" }}}
" ============================================================================
" CLIPBOARDs {{{
" ============================================================================

" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
if has('clipboard')
  " When possible use + register for copy-paste
  let sreg = has('unnamedplus') ? '+' : '*'
  " On mac and Windows, use * register for copy-paste
  " copy current file name (relative/absolute) to system clipboard
  " relative path  (src/foo.txt)
  nnoremap <expr><Leader>yp ":let @" . sreg . "=expand('%')<CR>"
  " absolute path  (/something/src/foo.txt)
  nnoremap <expr><Leader>ya ":let @" . sreg . "=expand('%:p')<CR>"
  " filename       (foo.txt)
  nnoremap <expr><Leader>yf ":let @" . sreg . "=expand('%:t')<CR>"
  " directory name (/something/src)
  nnoremap <expr><Leader>yd ":let @" . sreg . "=expand('%:p:h')<CR>"

  " easy system clipboard copy/paste
  noremap <expr><Leader>y   "\"" . sreg . "y"
  noremap <expr><Leader>yy  "\"" . sreg . "yy"
  noremap <expr><Leader>Y   "\"" . sreg . "y$"
  noremap <expr><Leader>p   "\"" . sreg . "p"
  noremap <expr><Leader>P   "\"" . sreg . "P"

  "use system clipboard as default
  "set clipboard=unnamed
endif

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrcEx
  autocmd!

  " Help in new tabs
  autocmd BufEnter *.txt call <sid>HelpTab()

  " highlight cursorline in active window
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Create directory if not exists
  autocmd BufWritePre * :silent !mkdir -p %:h

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell spelllang=ru_yo,en_us

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell spelllang=ru_yo,en_us

  " Unset paste on InsertLeave
  " autocmd InsertLeave * silent! set nopaste
augroup END

augroup tmux_auto_rename
  autocmd!
  if exists('$TMUX') && !exists('$NORENAME')
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

augroup Terminal
  autocmd!
  autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  autocmd WinEnter term://* startinsert
augroup END

" }}}
" ============================================================================
" plugin settings BLOCK {{{
" ============================================================================

source ~/.config/nvim/nvimrc.local

" }}}
