" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" FUNCTIONS {{{
" ============================================================================

source ~/.config/nvim/functions.vim

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

" https://github.com/junegunn/vim-plug
source ~/.config/nvim/nvimrc.plug

" }}}
" ============================================================================
" GUI BLOCK {{{
" ============================================================================

" if has('gui_running') && filereadable(expand("~/.vimrc.gui"))
"   source ~/.vimrc.gui
" endif

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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
" After applying above fix, below line is no longer necessary
" nnoremap <silent> <BS> :TmuxNavigateLeft<CR>

" <C-\><C-n> key combo, exit back to normal mode.
tnoremap hh <C-\><C-n>
tmap <C-k> hh<C-k>
tmap <C-j> hh<C-j>
tmap <C-h> hh<C-h>
tmap <C-l> hh<C-l>
tmap <C-\> hh<C-\>
" tt is mapped to :TernType
nnoremap <Leader>tv <C-w>v:te<CR>
nnoremap <Leader>te <C-w>s<C-w>J4<C-w>-:te<CR>

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


" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" OS X
set wildignore+=*.DS_Store
" Binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

set timeoutlen=400                   " mapping timeout
set ttimeoutlen=50                   " keycode timeout
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
set listchars=tab:»⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
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

" F1 will search help for the word under the cursor
nnoremap <F1> :help <C-r><C-w><CR>

" tab shortcuts
nnoremap g{ gt
nnoremap g} gT
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>

" ----------------------------------------------------------
" => Quick edit Mappings
" ----------------------------------------------------------
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

" use :NeoSnippetEdit -runtime
" nnoremap <Leader>ej :e ~/.vim/plugged/vim-snippets/snippets/javascript<CR>

" -----------------------------------------------------------
" => General mappings/shortcuts for functionality
" -----------------------------------------------------------
" Save
nnoremap <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>
" nnoremap <Leader>u :update<CR>

" w!! to sudo write
cmap w!! w !sudo tee % >/dev/null<CR>

" Quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>

" Enter visual line mode
nmap <Leader><leader> V

nnoremap <tab> %
vnoremap <tab> %

" make Y consistent with C and D. See :help Y.
nnoremap Y y$

" nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>co :copen<CR>
" nnoremap <Leader>cl :close<CR> " same as <C-w> c
nnoremap <Leader>cc :cclose<CR>
" following is shortcut for <C-w> z
nnoremap <Leader>cp :pclose<CR>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" reselect last paste
" nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
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

" fold a html tag
nnoremap <Leader>ft Vatzf

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
" nnoremap <Leader>g g<c-]>

" Switch to the directory of the open buffer
nnoremap <silent><Leader>cd :cd %:p:h<CR>

" Remove spaces at the end of lines
nnoremap <silent><Leader>w<Leader> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" Buffer reload
nnoremap <Leader>rr :e!<CR>

" switch between buffers
" provided by unimpaired [b
noremap <silent><Leader>bp :bprev<CR>
" provided by unimpaired ]b
noremap <silent><Leader>bn :bnext<CR>
noremap <silent><Leader>. <C-^><CR>

" zoom a vim pane, <C-w>= to re-balance
" nnoremap <Leader>z :wincmd _<CR>:wincmd \|<CR>
nnoremap <silent><Leader>- :wincmd =<CR>

" http://stackoverflow.com/questions/1262154/minimizing-vertical-vim-window-splits
set winminheight=0
nmap <Leader>j <C-W>j<C-W>_
nmap <Leader>k <C-W>k<C-W>_

set winminwidth=0
nmap <Leader>h <C-W>h500<C-W>>zz
nmap <Leader>l <C-W>l500<C-W>>zz

nnoremap <Leader>v <C-w>v

" resize panes
nnoremap <silent> <Right> :vertical resize +5<CR>
nnoremap <silent> <Left> :vertical resize -5<CR>
" nnoremap <silent> <Up> :resize +5<CR>
" nnoremap <silent> <Down> :resize -5<CR>

" toggle relativenumber: cor by unimpaired
" http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
"nnoremap <Leader>rn :set rnu!<ENTER>

" Show Registers
nnoremap <Leader>di :di<CR>

" http://habrahabr.ru/post/183222/
" spell check on
nnoremap <Leader>sp :setlocal spell spelllang=ru_yo,en_us<ENTER>
" spell check off
nnoremap <Leader>spp :setlocal spell spelllang=<ENTER>

" toggle search highlighting: coh by unimpaired
" nnoremap <silent><Leader>/ :set invhlsearch<CR>
nnoremap <Leader>hi :Highlight<CR>
nnoremap <silent><Leader>ch :call clearmatches()<CR>:noh<CR>

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
inoremap SS <Esc>cc
inoremap UU <C-O>u
noremap! hh <Esc>

" -----------------------------------------------------------
" => External cmd mappings
" -----------------------------------------------------------
" find current word in quickfix
nnoremap <Leader>* :execute "vimgrep ".expand("<cword>")." %"<CR>:copen<CR>
" find last search in quickfix
nnoremap <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
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
  if has('unnamedplus')  " When possible use + register for copy-paste
    nnoremap <Leader>yp :let @+=expand('%')<CR>
    nnoremap <Leader>ya :let @+=expand('%:p')<CR>
    nnoremap <Leader>yf :let @+=expand('%:t')<CR>
    nnoremap <Leader>yd :let @+=expand('%:p:h')<CR>

    noremap <Leader>y "+y
    noremap <Leader>yy "+yy
    noremap <Leader>Y "+y$
    noremap <Leader>p "+p
    noremap <Leader>P "+P
  else
    " On mac and Windows, use * register for copy-paste
    " copy current file name (relative/absolute) to system clipboard
    " relative path  (src/foo.txt)
    nnoremap <Leader>yp :let @*=expand('%')<CR>
    " absolute path  (/something/src/foo.txt)
    nnoremap <Leader>ya :let @*=expand('%:p')<CR>
    " filename       (foo.txt)
    nnoremap <Leader>yf :let @*=expand('%:t')<CR>
    " directory name (/something/src)
    nnoremap <Leader>yd :let @*=expand('%:p:h')<CR>

    " easy system clipboard copy/paste
    noremap <Leader>y "*y
    noremap <Leader>yy "*yy
    noremap <Leader>Y "*y$
    noremap <Leader>p "*p
    noremap <Leader>P "*P
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

  " Help in new tabs
  autocmd BufEnter *.txt call Helptab()

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
  autocmd InsertLeave * silent! set nopaste
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
" vimrc.local BLOCK {{{
" ============================================================================

source ~/.config/nvim/nvimrc.local

" }}}
