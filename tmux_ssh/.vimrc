" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" " VUNDLE BLOCK {{{
" ============================================================================
" Install Plug -> faster
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug 'vim-scripts/matchit.zip'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-characterize' " enhaced ga
Plug 'tpope/vim-capslock'     " <C-G>c in insert mode
Plug 'tpope/vim-unimpaired'
Plug 'tommcdo/vim-exchange'
Plug 'rafi/vim-tinyline'
" Plugin 'kshenoy/vim-signature'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vbauerster/vim-highlighter'

" Motions
" Plug 'justinmk/vim-sneak'

" Misc.
Plug 'romainl/vim-qf'
Plug 'blueyed/vim-qf_resize'

" Initialize plugin system
call plug#end()

" }}}
" ============================================================================
" Script local functions {{{
" ============================================================================

function! s:helptab()
  if &buftype ==# "help"
    wincmd T
    nnoremap <buffer> q :q<CR>
  endif
endfunction

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
    \        : ((bot < top ? bot : top) - line('.')).'j'
endfunction

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

" set nocompatible
set t_Co=256

let mapleader = ' '
let maplocalleader = ' '

set background=light
" colorscheme lxvc
" colorscheme pyte
colorscheme fx

set ttyfast
set encoding=utf-8
" set pastetoggle=<F3>
set history=1000               " nvim sets this to 1000 by default
set undolevels=1000            " nvim sets this to 1000 by default
set autoread                   " detect when a file is changed
set hlsearch                   " Highlight search terms

" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" Binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

set number
set wildmode=list:longest            " TAB auto-completion for file paths
set hidden                           " current buffer can be put into background
set showcmd                          " show incomplete commands
set scrolloff=2                      " lines of text around cursor
set foldlevelstart=99                " all folds open by default
set cmdheight=1                      " command bar height
set noerrorbells
set complete=.,w,t
set completeopt=menu,longest


" SPACES & TABS
" Explanations from http://tedlogan.com/techblog3.html
set tabstop=2     " How many columns a tab counts for
set softtabstop=2 " How many columns vim uses when pressing TAB in insert mode
set shiftwidth=2  " How many columns text is indented with << and >>
set expandtab     " Use spaces
set smartindent   " Normally 'autoindent' should also be on when using 'smartindent'
set nojoinspaces  " Prevents inserting two spaces after punctuation on a join (J)

" Searching
set gdefault   " global search by default
set ignorecase " case insensitive searching
set smartcase  " case-sensitive if expresson contains a capital letter
set lazyredraw " don't redraw while executing macros

" Highlight current line
" http://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim
set cursorline

" Open new split panes to right and bottom, which feels more natural
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Whitespaces
set listchars=tab:»⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮

" backup/persistance settings
set noswapfile

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================
" open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" reload vimrc
nnoremap <leader>rs :source $MYVIMRC<CR>
" edit tmux.conf
nnoremap <leader>et :e ~/.tmux.conf<CR>
" edit logs
nnoremap <leader>em :e /var/log/messages<CR>

" set working directory to the current buffer's directory
nnoremap cd :lcd %:p:h<bar>pwd<cr>
nnoremap cu :lcd ..<bar>pwd<cr>
nnoremap cD :cd %:p:h<bar>pwd<cr>
nnoremap cU :cd ..<bar>pwd<cr>
nnoremap <leader>pp :pwd<CR>

" Swap implementations of ` and ' jump to markers
nnoremap ' `
" nnoremap ` '

" don't override enter behavior in quickfix/location windows
nnoremap <expr> <Enter> (&buftype is# "quickfix" ? "\<cr>" : "%")

" F1 will search help for the word under the cursor
nnoremap <F1> :help <C-r><C-w><CR>

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
nnoremap <Leader>!! :qa!<CR>
" buffer delete
nnoremap <silent> <Leader>xx :bd<CR>

" Save in normal mode
nnoremap <F2> :up<CR>

" Buffer reload
nnoremap <Leader>er :e!<CR>

" Read :help ctrl-w_w
" Read :help wincmd
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

" quickly access yank reg
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

" reselect last paste
nnoremap gp `[v`]

" Search in normal mode with very magic on
" nnoremap / /\v
" nnoremap ? ?\v

" moving up and down work as you would expect
nnoremap j gj
nnoremap k gk
" nnoremap ^ g^
" nnoremap $ g$

nnoremap '+ z+
nnoremap '- z-

" vim-vertical-move
nnoremap <expr> <C-j> <SID>vjump(0)
nnoremap <expr> <C-k> <SID>vjump(1)
xnoremap <expr> <C-j> <SID>vjump(0)
xnoremap <expr> <C-k> <SID>vjump(1)
onoremap <expr> <C-j> <SID>vjump(0)
onoremap <expr> <C-k> <SID>vjump(1)

" auto center
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" fold a html tag
" nnoremap <leader>ft Vatzf
nnoremap <Leader>ft zfat
nnoremap <Leader>fb zfaB

" Wipe xxx {} block
nnoremap <Leader>xB vaBo0d

" Read :help g_ctrl-]
" same as :tjump
" jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <c-]> g<c-]>
" prefer :ptjump to :ptag
" nnoremap <C-w>} <C-w>g}

" Remove spaces at the end of lines
" nnoremap <silent><Leader>w<Leader> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" switch between buffers
" bprev provided by unimpaired [b
" bnext provided by unimpaired ]b
nnoremap <silent>,. <C-^><CR>
" nnoremap <silent> <F10> :bd<CR>

" http://habrahabr.ru/post/183222/
" spell toggle
nnoremap <Leader>sp :setlocal spell! spelllang=ru_yo,en_us<CR>
" spell check off
" nnoremap <Leader>spp :setlocal spell spelllang=<ENTER>

" Highlight word
nnoremap <Leader>hw :Highlight<CR>
nnoremap <silent><Leader>hc :call clearmatches()<CR>:noh<CR>

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

nnoremap <M-Left> <C-w>>
nnoremap <M-Right> <C-w><
nnoremap <M-Up> <C-w>+
nnoremap <M-Down> <C-w>-

" -----------------------------------------------------------
" => vimgrep
" -----------------------------------------------------------
" nmap <Leader>* ]I
" nmap <Leader># [I

" <leader>ff shows list for relative jump
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" -----------------------------------------------------------
" => Insert mode mappings
" -----------------------------------------------------------
" Start new line
" inoremap <S-Return> <C-o>o

" insert absolute current buffer path
inoremap <F4> <C-R>=expand('%:p')<CR>

" quick movements
" http://vim.wikia.com/wiki/Quick_command_in_insert_mode
inoremap II <Esc>I
inoremap AA <Esc>A
" <C-\> does not eat last char of the line
inoremap CC <C-\><C-O>D

" http://superuser.com/a/1165038/578741
inoremap <F2> <C-\><C-o>:w<CR>
inoremap <silent> ,. <Esc>:up<CR>

" upper case
inoremap UU <Esc>gUiw`]a

" imap     <Nul> <C-Space>
" inoremap <C-Space> <C-x><C-l>

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
vnoremap <C-r> "hy:%S/<C-r>h//c<left><left>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv

" -----------------------------------------------------------
" => Command mode mappings
" -----------------------------------------------------------
" refer to the directory of the current file, regardless of pwd
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" quick save without hitting enter
" cnoremap ;h <C-u>w<CR>
" quick pwd
" cnoremap ;d <C-u>pwd<CR>
" Quit all without save
" cnoremap ;! <C-u>qa!<CR>
cnoremap >> <C-u>qa!<CR>

cnoremap <C-A> <Home>
cnoremap <C-O> <Up>

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================
augroup Vimrc_au
  autocmd!

  " Remove trailing whitespaces
  autocmd BufWritePre * :%s/\s\+$//e

  " Help in new tabs
  autocmd BufEnter *.txt call <sid>helptab()

  " highlight cursorline in active window
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Create directory if not exists
  autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  " :h last-position-jump
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

augroup FileType_au
  au!
  au FileType sh,xml,html,javascript   setl ts=2 sts=2 sw=2 et
  au FileType py,markdown              setl ts=4 sts=4 sw=4 et
  au FileType go                       setl ts=4 sts=4 sw=4 noet
  au FileType markdown,gitcommit       setl spell spelllang=ru_yo,en_us
  au FileType gitcommit                setl textwidth=72
  au FileType markdown                 setl textwidth=80
augroup END

" augroup tmux_auto_rename
"   autocmd!
"   if exists('$TMUX') && !exists('$NORENAME')
"     autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
"     autocmd VimLeave * call system('tmux set-window automatic-rename on')
"   endif
" augroup END
" }}}
" ============================================================================
" 'tpope/vim-fugitive' {{{
" ============================================================================
nnoremap <silent> <leader>gg :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gcc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gv :Gvsplit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" Git add %
" gs for g stage
nnoremap <silent> <leader>gs :Gwrite<CR>
" Git rm %
nnoremap <silent> <leader>gx :Gremove<CR>
" Git checkout %
nnoremap <silent> <leader>gu :Gread<CR>

au FileType gitcommit nnoremap <buffer> <silent> cn :<C-U>Gcommit --amend --date="$(date)"<CR>

" }}}
" ============================================================================
" 'junegunn/gv.vim' {{{
" ============================================================================
" Commits All
nnoremap <silent> <leader>gca :GV<CR>
" Commitns Only of the current file
nnoremap <silent> <leader>gco :GV!<CR>
" Commits Revisions of the current file
nnoremap <silent> <leader>gcr :GV?<CR>

" }}}
" ============================================================================
" 'romainl/vim-qf' {{{
" ============================================================================
let g:qf_mapping_ack_style = 1

" https://github.com/romainl/vim-qf/issues/44
" https://github.com/romainl/vim-qf/pull/48
" https://github.com/neomake/neomake/issues/1097#issuecomment-298780826
let g:qf_auto_open_loclist = 0
let g:qf_auto_open_quickfix = 0
" disable auto resize, let vim-qf_resize plugin manage it
let g:qf_auto_resize = 0
" let g:qf_loclist_window_bottom = 0
" let g:qf_window_bottom = 0

nmap <Leader>cc <Plug>(qf_loc_toggle_stay)
nmap <Leader>cq <Plug>(qf_qf_toggle_stay)
nmap <Leader>cw <Plug>(qf_qf_switch)
nmap [. <Plug>(qf_loc_previous)
nmap ].  <Plug>(qf_loc_next)

" nnoremap <silent> <F11> :lcl<CR>
" nnoremap <silent> <F12> :ccl<CR>
" }}}
" ============================================================================
" 'justinmk/vim-sneak' {{{
" ============================================================================

" let g:sneak#prompt = 'sneak›'
" To enable 'passive' or 'smart' streak-mode
" let g:sneak#streak = 1
" Enable the 'clever-s' feature
" let g:sneak#s_next = 1
" Case sensitivity is determined by 'ignorecase' and 'smartcase'.
" let g:sneak#use_ic_scs = 1

" replace 'f' with 1-char Sneak
" nmap f <Plug>Sneak_f
" nmap F <Plug>Sneak_F
" xmap f <Plug>Sneak_f
" xmap F <Plug>Sneak_F
" omap f <Plug>Sneak_f
" omap F <Plug>Sneak_F
" replace 't' with 1-char Sneak
" nmap t <Plug>Sneak_t
" nmap T <Plug>Sneak_T
" xmap t <Plug>Sneak_t
" xmap T <Plug>Sneak_T
" omap t <Plug>Sneak_t
" omap T <Plug>Sneak_T

" }}}
