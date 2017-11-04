" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" VUNDLE BLOCK {{{
" ============================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'vim-scripts/matchit.zip'
" Plugin 'morhetz/gruvbox'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-characterize' " enhaced ga
Plugin 'tpope/vim-capslock'     " <C-G>c in insert mode
Plugin 'tpope/vim-unimpaired'
Plugin 'tommcdo/vim-exchange'
Plugin 'rafi/vim-tinyline'
Plugin 'kshenoy/vim-signature'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'

" Plugin 'junegunn/vim-peekaboo'
Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'vbauerster/vim-highlighter'

" Tmux
" Plugin 'christoomey/vim-tmux-navigator'

" Motions
Plugin 'justinmk/vim-sneak'

" Misc.
Plugin 'romainl/vim-qf'
Plugin 'blueyed/vim-qf_resize'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" }}}
" ============================================================================
" Script local functions {{{
" ============================================================================
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
" COLORSCHEME {{{
" ============================================================================
  set background=dark
  " let g:gruvbox_contrast_light='hard'
  " let g:gruvbox_contrast_dark='soft'
  " let g:gruvbox_italic=1
  " let g:gruvbox_improved_strings=1
  " let g:gruvbox_improved_warnings=1
  " colorscheme seoul256-light
  colorscheme seoul256
" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
let mapleader = ' '
let maplocalleader = ' '

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
set tabstop=4     " How many columns a tab counts for
set softtabstop=4 " insert mode behaviour of TAB and BS
set shiftwidth=0  " When zero the 'ts' value will be used
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

" Open new split panes to right and bottom, which feels more natural
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Whitespaces
set list " col to toggle
set listchars=tab:›⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮

" backup/persistance settings
set noswapfile
" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================
" open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
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

" In normal mode, we use : much more often than ; so lets swap them.
" WARNING: this will cause any "ordinary" map command without the "nore" prefix
" that uses ":" to fail. For instance, "map <f2> :w" would fail, since vim will
" read ":w" as ";w" because of the below remappings. Use "noremap"s in such
" situations and you'll be fine.
noremap ; :
xnoremap ; :

" Swap implementations of ` and ' jump to markers
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
nnoremap g} gt
nnoremap g{ gT
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>to :tabonly<CR>

" Go to last active tab
" https://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim#2120168
" https://superuser.com/questions/410982/in-vim-how-can-i-quickly-switch-between-tabs
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <Leader>tt :exe "tabn ".g:lasttab<CR>

" Quit nvim
nnoremap <Leader>q :q<CR>
nnoremap <Leader>! :q!<CR>
nnoremap <silent> <F10> :bd<CR>

" F1 will search help for the word under the cursor
nnoremap <F1> :help <C-r><C-w><CR>

" Save in normal mode
nnoremap <F2> :w<CR>

" Buffer reload
nnoremap <Leader>R :e!<CR>

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


" Search in normal mode with very magic on
" nnoremap / /\v
" nnoremap ? ?\v

" This makes j and k work on "screen lines" instead of on "file lines"; now, when
" we have a long line that wraps to multiple screen lines, j and k behave as we
" expect them to.
nnoremap j gj
nnoremap k gk
" nnoremap ^ g^
" nnoremap $ g$

nnoremap '+ z+
nnoremap '- z-

noremap + 5gj
noremap - 5gk

noremap <M-+> 14gj
noremap <M--> 14gk

" vim-vertical-move
nnoremap <expr> <M-j> <SID>vjump(0)
nnoremap <expr> <M-k> <SID>vjump(1)
noremap <expr> gj <SID>vjump(0)
noremap <expr> gk <SID>vjump(1)

" auto center
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" fold a html tag
nnoremap <leader>ft Vatzf
nnoremap <Leader>fb zfaB

" Wipe xxx {} block
nnoremap <Leader>bx vaBo0d

" Read :help g_ctrl-]
" same as :tjump
" jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <C-]> g<C-]>
" prefer :ptjump to :ptag
" nnoremap <C-w>} <C-w>g}

" Remove spaces at the end of lines
" nnoremap <silent><Leader>w<Leader> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" switch between buffers
nnoremap <silent>,. <C-^><CR>

" http://habrahabr.ru/post/183222/
" spell toggle
nnoremap <Leader>sp :setlocal spell! spelllang=ru_yo,en_us<CR>
" spell check off
" nnoremap <Leader>spp :setlocal spell spelllang=<ENTER>

" Highlight word
nnoremap <F7> :Highlight<CR>
nnoremap <silent><Leader>cc :call clearmatches()<CR>:noh<CR>

" -----------------------------------------------------------
" => Diff3 merge
" -----------------------------------------------------------
nnoremap <silent><Leader>dl :diffget LOCAL \| diffupdate<CR>
nnoremap <silent><Leader>dr :diffget REMOTE \| diffupdate<CR>

" -----------------------------------------------------------
" => h: window-resize
" -----------------------------------------------------------
nnoremap <silent> <Leader>= :wincmd =<cr>:QfResizeWindows<cr>
nnoremap <Leader>z <C-w><Bar><C-w>_
nnoremap <Leader>o <C-w>o
nnoremap <Leader>v <C-w>v

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
" nnoremap <F3> :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" -----------------------------------------------------------
" => Insert mode mappings
" -----------------------------------------------------------
" Start new line
inoremap <S-Return> <C-o>o

" insert absolute current buffer path
" inoremap <F4> <C-R>=expand('%:p')<CR>

" quick movements
" http://vim.wikia.com/wiki/Quick_command_in_insert_mode
inoremap II <Esc>I
inoremap AA <Esc>A
" CTRL-\ CTRL-O like CTRL-O but don't move the cursor [i_CTRL-\_CTRL-O]
inoremap CC <C-\><C-O>D

" upper case
inoremap UU <Esc>gUiw`]a

imap     <Nul> <C-Space>
inoremap <C-Space> <C-x><C-l>

" http://superuser.com/a/1165038/578741
inoremap <F2> <C-\><C-o>:w<CR>
inoremap <silent> ,. <Esc>:up<CR>

" inoremap <insert> <C-r>*

" -----------------------------------------------------------
" => Visual and Select mode mappings
" -----------------------------------------------------------
vnoremap ,. <Esc>

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
" quick save without hitting enter
" cnoremap ;h <C-u>w<CR>
" close location list
" cnoremap cc <C-u>lcl<CR>
" cnoremap ww <C-u>pwd<CR>
" Quit all, but ask to save
cnoremap !! <C-u>qa!<CR>

cnoremap <C-A> <Home>
cnoremap <C-O> <Up>

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrcEx
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

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell spelllang=ru_yo,en_us

  " Unset paste on InsertLeave
  autocmd InsertLeave * silent! set nopaste
augroup END

augroup Markdown_au
  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell spelllang=ru_yo,en_us
  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END
" }}}
" ============================================================================
" 'tpope/vim-fugitive' {{{
" ============================================================================
nnoremap <silent> <leader>gg :Gstatus<CR><C-w>J<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gs :Gvsplit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" Git add %
nnoremap <silent> g+ :Gwrite<CR>
" Git rm %
nnoremap <silent> g- :Gremove<CR>
" Git checkout %
" mnemominc git undo
nnoremap <silent> <leader>gu :Gread<CR>

au FileType gitcommit nnoremap <buffer> <silent> cn :<C-U>Gcommit --amend --date="$(date)"<CR>
" }}}
" ============================================================================
" 'junegunn/gv.vim' {{{
" ============================================================================
" Commits All
nnoremap  g/ :GV<CR>
" Commits Only of the current file
nnoremap  g= :GV!<CR>
" Commits Revisions of the current file
nnoremap  <Leader>g= :GV?<CR>
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

nmap <F11> <Plug>qf_loc_stay_toggle
nmap <F12> <Plug>qf_qf_stay_toggle
nmap <Leader><tab> <Plug>qf_qf_switch
nmap [. <Plug>qf_loc_previous
nmap ]. <Plug>qf_loc_next

" nnoremap <silent> <F11> :lcl<CR>
" nnoremap <silent> <F12> :ccl<CR>
" }}}
" ============================================================================
" 'justinmk/vim-sneak' {{{
" ============================================================================
" let g:sneak#prompt = 'sneak›'
" To enable 'passive' or 'smart' streak-mode
let g:sneak#streak = 1
" Enable the 'clever-s' feature
let g:sneak#s_next = 1
" Case sensitivity is determined by 'ignorecase' and 'smartcase'.
let g:sneak#use_ic_scs = 1

" replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
" replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
" }}}
