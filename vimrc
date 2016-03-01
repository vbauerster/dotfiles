" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

" https://github.com/junegunn/vim-plug
if filereadable(expand("~/.vimrc.plug"))
  source ~/.vimrc.plug
endif

" }}}
" ============================================================================
" GUI BLOCK {{{
" ============================================================================

if has('gui_running') && filereadable(expand("~/.vimrc.gui"))
  source ~/.vimrc.gui
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

let mapleader = ' '
let maplocalleader = ' '

execute "set background=".$BACKGROUND
colorscheme gruvbox

if $BACKGROUND == 'dark'
  let g:gruvbox_contrast_dark='soft'
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  " <C-\><C-n> key combo, exit back to normal mode.
  tnoremap hh <C-\><C-n>
  tmap <C-k> hh<C-k>
  tmap <C-j> hh<C-j>
  tmap <C-h> hh<C-h>
  tmap <C-l> hh<C-l>
  " tt is mapped to :TernType
  nnoremap <leader>tv <C-w>v:te<CR>
  nnoremap <leader>te <C-w>s<C-w>J4<C-w>-:te<CR>

  " Setup Terminal Colors For Neovim
  " remove, when https://github.com/morhetz/gruvbox/pull/93 will be accepted

  " dark0 + gray
  let g:terminal_color_0 = "#282828"
  let g:terminal_color_8 = "#928374"
  " neurtral_red + bright_red
  let g:terminal_color_1 = "#cc241d"
  let g:terminal_color_9 = "#fb4934"
  " neutral_green + bright_green
  let g:terminal_color_2 = "#98971a"
  let g:terminal_color_10 = "#b8bb26"
  " neutral_yellow + bright_yellow
  let g:terminal_color_3 = "#d79921"
  let g:terminal_color_11 = "#fabd2f"
  " neutral_blue + bright_blue
  let g:terminal_color_4 = "#458588"
  let g:terminal_color_12 = "#83a598"
  " neutral_purple + bright_purple
  let g:terminal_color_5 = "#b16286"
  let g:terminal_color_13 = "#d3869b"
  " neutral_aqua + faded_aqua
  let g:terminal_color_6 = "#689d6a"
  let g:terminal_color_14 = "#8ec07c"
  " light4 + light1
  let g:terminal_color_7 = "#a89984"
  let g:terminal_color_15 = "#ebdbb2"

  augroup Terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    au WinEnter term://* startinsert
  augroup END

else
  " sets for vim only, see h: vim-differences
  set nocompatible
  set t_Co=256
  set ttyfast
  set encoding=utf-8
  syntax on
  " https://github.com/neovim/neovim/issues/2092
  "set pastetoggle=<F2> " vim-unimpaired provides 'yo' mapping
  set history=1000               " nvim sets this to 1000 by default
  set undolevels=1000            " nvim sets this to 1000 by default
  set backspace=indent,eol,start
  set autoindent                 " Indent at the same level of the previous line
  set autoread                   " detect when a file is changed
  set smarttab                   " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
  set hlsearch                   " Highlight search terms
  set incsearch                  " set incremental search, like modern browsers
  set laststatus=2
  set wildmenu                   " enhanced command line completion
  set tags=./tags;/
endif

" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" OS X
set wildignore+=*.DS_Store
" Binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

set timeoutlen=333                                  "mapping timeout
set ttimeoutlen=50                                  "keycode timeout
set number
set dictionary=/usr/share/dict/words " CTRL-X CTRL-K to autocomplete
set wildmode=list:longest            " TAB auto-completion for file paths
set hidden                           " current buffer can be put into background
set showcmd                          " show incomplete commands
set noshowmode                       " don't show which mode disabled for PowerLine
set scrolloff=3                      " lines of text around cursor
set foldlevelstart=99                " all folds open by default
set cmdheight=1                      " command bar height
set noerrorbells
" set completeopt-=preview
set completeopt=menuone

"set autowrite     " Automatically :write before running commands

" SPACES & TABS
" Explanations from http://tedlogan.com/techblog3.html
set tabstop=2     " How many columns a tab counts for
set softtabstop=2 " How many columns vim uses when pressing TAB in insert mode
set shiftwidth=2  " How many columns text is indented with << and >>
set expandtab     " Use spaces
set smartindent   " Normally 'autoindent' should also be on when using 'smartindent'
"set shiftround    " round indent to a multiple of 'shiftwidth'

set ruler                " show the cursor position a l the time
set nojoinspaces         " Prevents inserting two spaces after punctuation on a join (J)

" Searching
set gdefault   " global search by default
set ignorecase " case insensitive searching
set smartcase  " case-sensitive if expresson contains a capital letter
set lazyredraw " don't redraw while executing macros

" Highlight current line
" http://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim
set cursorline
" Highlight current line nr
"highlight cursorlinenr ctermbg=0 ctermfg=14
" highlight cursorlinenr ctermfg=14

" if textwidth > 80 highlight overlenght with reddish bg
" set textwidth=80
" highlight OverLength ctermbg=223 guibg=#592929
" match OverLength /\%81v.\+/

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
"set spellfile=$HOME/.vim-spell-en.utf-8.add

" Open new split panes to right and bottom, which feels more natural
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Whitespaces
set listchars=tab:»⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
" set showbreak=↪
" show invisible chars by default
" set list "use col by unimpaired

" backup/persistance settings
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backupskip=/tmp/*,/private/tmp/*"
set backup " delete old backup, backup current file
set undofile
set noswapfile

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" F1 will search help for the word under the cursor
nnoremap <F1> :help <C-r><C-w><CR>

" easy moving between tabs
nnoremap g{ gT
nnoremap g} gt

" ----------------------------------------------------------
" => Quick edit Mappings
" ----------------------------------------------------------
" open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" edit vim plugins
nnoremap <leader>ep :e ~/.vimrc.plug<CR>
" edit vim local
nnoremap <leader>el :e ~/.vimrc.local<CR>
" edit gitconfig
nnoremap <leader>eg :e ~/.gitconfig<CR>
" edit tmux.conf
nnoremap <leader>et :e ~/.tmux.conf<CR>
" edit zshrc
nnoremap <leader>ez :e ~/.zshrc<CR>

nnoremap <leader>ej :e ~/.vim/plugged/vim-snippets/snippets/javascript<CR>

" -----------------------------------------------------------
" => General mappings/shortcuts for functionality
" -----------------------------------------------------------
" Save
nnoremap <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>
" nnoremap <leader>u :update<CR>

" w!! to sudo write
cmap w!! w !sudo tee % >/dev/null<CR>

" Quit
inoremap <C-Q>     <esc>:q<CR>
nnoremap <C-Q>     :q<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" Enter visual line mode
nmap <leader><leader> V

nnoremap <tab> %
vnoremap <tab> %

" make Y consistent with C and D. See :help Y.
nnoremap Y y$

nnoremap <leader>lo :lopen<CR>
nnoremap <leader>co :copen<CR>
" nnoremap <leader>cl :close<CR> " same as <C-w> c
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>pc :pclose<CR> " same as <C-w> z

" reselect visual block after indent
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" reselect last paste
" nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap gp `[v`]

" Search in normal mode with very magic on
nnoremap / /\v
nnoremap ? ?\v
" Search in visually selected block only
vnoremap / <Esc>/\%V\v
vnoremap ? <Esc>?\%V\v

vmap <leader>s :sort<CR>

" paste multiple lines multiple times
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" Swap implementations of ` and ' jump to markers
nnoremap <silent> ' `
nnoremap <silent> ` '

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" auto center
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" tab shortcuts
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>

" fold a html tag
nnoremap <leader>ft Vatzf

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
" nnoremap <leader>g g<c-]>

" Switch to the directory of the open buffer
nnoremap <silent> <leader>cd :cd %:p:h<CR>

" remove trailing whitespace and clear the last search pattern
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" toggle search highlighting: coh by unimpaired
" nmap <silent> <leader>/ :set invhlsearch<CR>
" toggle invisible characters: col by unimpaired
" nmap <leader>l :set list!<CR>

" switch between current and last buffer
" qpkorr/vim-bufkill provides :BA ~ <c-^>
nmap <silent> <leader>; :bp<CR>
nmap <silent> <leader>, :bn<CR>
nmap <silent> <leader>. <C-^><CR>

" zoom a vim pane, <C-w>= to re-balance
" nnoremap <leader>z :wincmd _<CR>:wincmd \|<CR>
nmap <silent> <leader>- :wincmd =<CR>

" http://stackoverflow.com/questions/1262154/minimizing-vertical-vim-window-splits
set winminheight=0
nmap <leader>j <C-W>j<C-W>_
nmap <leader>k <C-W>k<C-W>_

set winminwidth=0
nmap <leader>h <C-W>h500<C-W>>
nmap <leader>l <C-W>l500<C-W>>

nnoremap <leader>v <C-w>v

" resize panes
nnoremap <silent> <Right> :vertical resize +5<CR>
nnoremap <silent> <Left> :vertical resize -5<CR>
" nnoremap <silent> <Up> :resize +5<CR>
" nnoremap <silent> <Down> :resize -5<CR>

" toggle relativenumber: cor by unimpaired
" http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
"nnoremap <leader>rn :set rnu!<ENTER>

" Buffer reload
nnoremap <leader>rr :e!<CR>
" nnoremap <leader>ll :ls<CR>
" nnoremap <leader>bn :bn<CR> "provided by unimpaired ]b
" nnoremap <leader>bp :bp<CR> "provided by unimpaired [b

" Show Registers
nnoremap <leader>di :di<CR>

" http://habrahabr.ru/post/183222/
" spell check on
nnoremap <leader>sp :setlocal spell spelllang=ru_yo,en_us<ENTER>
" spell check off
nnoremap <leader>spp :setlocal spell spelllang=<ENTER>

nnoremap <leader>hi :Highlight<CR>
nnoremap <silent> <leader>hc :call clearmatches()<CR>:noh<CR>

" experimental: quickly access yank reg
noremap "" "0

" quick access to cmd mode
noremap ; :

" -----------------------------------------------------------
" => Command mode mappings
" -----------------------------------------------------------
" refer to the directory of the current file, regardless of pwd
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" -----------------------------------------------------------
" => Insert mode mappings
" -----------------------------------------------------------
" insert absolute current buffer path
inoremap <F2> <C-R>=expand('%:p')<CR>

" quick movements
" http://vim.wikia.com/wiki/Quick_command_in_insert_mode
inoremap II <Esc>I
inoremap AA <Esc>A
" <C-\> does not eat last char of the line
inoremap CC <C-\><C-O>D
inoremap SS <Esc>cc
inoremap UU <C-O>u
inoremap hh <Esc>

" -----------------------------------------------------------
" => External cmd mappings
" -----------------------------------------------------------
" find current word in quickfix
nnoremap <leader>b* :execute "vimgrep ".expand("<cword>")." %"<CR>:copen<CR>
" find last search in quickfix
nnoremap <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" http://stackoverflow.com/questions/3166413/execute-a-script-directly-within-vim-mvim-gvim
nnoremap <leader>nh :write !node --harmony<CR>
" see ':h :!'; '.' stands for concatination
nnoremap <leader>nn :exe "!babel-node " . shellescape(expand("%"))<CR>

" reload ctags, --fields=+l needs by YCM
" http://stackoverflow.com/questions/25819649/exuberant-ctags-exclude-directories#25819720
" http://raygrasso.com/posts/2015/04/using-ctags-on-modern-javascript.html
nnoremap <leader>ct :!gtags -R --fields=+l --exclude=.git --exclude=node_modules --exclude=jspm_packages --exclude=log --exclude=tmp *<CR><CR>

" }}}
" ============================================================================
" CLIPBOARDs {{{
" ============================================================================

" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    nnoremap <leader>yp :let @+=expand('%')<CR>
    nnoremap <leader>ya :let @+=expand('%:p')<CR>
    nnoremap <leader>yf :let @+=expand('%:t')<CR>
    nnoremap <leader>yd :let @+=expand('%:p:h')<CR>

    noremap <leader>y "+y
    noremap <leader>yy "+yy
    noremap <leader>Y "+y$
    noremap <leader>p "+p
    noremap <leader>P "+P
  else " On mac and Windows, use * register for copy-paste
    " copy current file name (relative/absolute) to system clipboard
    " relative path  (src/foo.txt)
    nnoremap <leader>yp :let @*=expand('%')<CR>
    " absolute path  (/something/src/foo.txt)
    nnoremap <leader>ya :let @*=expand('%:p')<CR>
    " filename       (foo.txt)
    nnoremap <leader>yf :let @*=expand('%:t')<CR>
    " directory name (/something/src)
    nnoremap <leader>yd :let @*=expand('%:p:h')<CR>

    " easy system clipboard copy/paste
    noremap <leader>y "*y
    noremap <leader>yy "*yy
    noremap <leader>Y "*y$
    noremap <leader>p "*p
    noremap <leader>P "*P
    "use system clipboard as default
    "set clipboard=unnamed
  endif
endif

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrcEx
  autocmd!

  " highlight cursorline in active window
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Create directory if not exists
  " CTRLP plugin provides same functionality via <c-y>
  autocmd BufWritePre * :silent !mkdir -p %:h

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  " autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell spelllang=ru_yo,en_us

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell spelllang=ru_yo,en_us

  " Allow stylesheets to autocomplete hyphenated words
  " autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

augroup tmux_auto_rename
  autocmd!
  if exists('$TMUX') && !exists('$NORENAME')
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" ----------------------------------------------------------------------------
" Help in new tabs
" ----------------------------------------------------------------------------
function! s:helptab()
  if &buftype == 'help'
    wincmd T
    nnoremap <buffer> q :q<CR>
  endif
endfunction

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt call s:helptab()
augroup END

" }}}
" ============================================================================
" vimrc.local BLOCK {{{
" ============================================================================

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}
