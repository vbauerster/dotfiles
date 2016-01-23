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
" GUI or TERM {{{
" ============================================================================

if has('gui_running') && filereadable(expand("~/.vimrc.gui"))
	source ~/.vimrc.gui
else
	if &term == 'xterm' || &term == 'screen'
		" Enable 256 colors to stop the CSApprox warning and make xterm vim shine
		set t_Co=256
		"custom search (*) highlight
		if $BACKGROUND == 'dark'
			highlight search ctermfg=16 ctermbg=137
		else
			highlight search ctermfg=228 ctermbg=240
		endif
	endif
endif

" }}}
" ============================================================================
" CLIPBOARD {{{
" ============================================================================

if has('clipboard')
	if has('unnamedplus')  " When possible use + register for copy-paste
		" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
		" copy current file name (relative/absolute) to system clipboard
		" relative path (src/foo.txt)
		nnoremap <leader>cp :let @+=expand("%")<CR>
		" absolute path (/something/src/foo.txt)
		nnoremap <leader>cP :let @+=expand("%:p")<CR>
		" filename (foo.txt)
		nnoremap <leader>cf :let @+=expand("%:t")<CR>
		" directory name (/something/src)
		nnoremap <leader>ch :let @+=expand("%:p:h")<CR>

		" easy system clipboard copy/paste
		noremap <leader>y "+y
		noremap <leader>yy "+yy
		noremap <leader>Y "+y$
		noremap <leader>p "+p
		noremap <leader>P "+P
		"use system clipboard as default
		"set clipboard=unnamed,unnamedplus
	else         " On mac and Windows, use * register for copy-paste
		" relative path  (src/foo.txt)
		nnoremap <leader>cp :let @*=expand("%")<CR>
		" absolute path  (/something/src/foo.txt)
		nnoremap <leader>cP :let @*=expand("%:p")<CR>
		" filename       (foo.txt)
		nnoremap <leader>cf :let @*=expand("%:t")<CR>
		" directory name (/something/src)
		nnoremap <leader>ch :let @*=expand("%:p:h")<CR>

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
" BASIC SETTINGS {{{
" ============================================================================

let mapleader = ','
let maplocalleader = ','

" Color scheme
syntax on
execute "set background=".$BACKGROUND
colorscheme solarized

if has('nvim') " sets for nvim only
  " https://github.com/neovim/neovim/issues/2048
  " https://github.com/christoomey/vim-tmux-navigator/issues/71
  nnoremap <silent> <BS> :TmuxNavigateLeft<CR>
  tnoremap <C-b> <C-\><C-n>
	" nnoremap <leader>te <C-w>v:te<CR>
	nnoremap <leader>tm <C-w>s<C-w>J4<C-w>-:te<CR>
else " sets for vim only
  set nocompatible
  " https://github.com/neovim/neovim/issues/2092
  "set pastetoggle=<F2> " vim-unimpaired provides 'yo' mapping
  set history=1000     " nvim sets this to 1000 by default
  set undolevels=1000  " nvim sets this to 1000 by default
  set backspace=indent,eol,start
endif

" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" OS X
set wildignore+=*.DS_Store
" Binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

set timeoutlen=500
set encoding=utf-8
set number
set laststatus=2
set dictionary=/usr/share/dict/words " CTRL-X CTRL-K to autocomplete
set wildmenu                         " enhanced command line completion
set wildmode=list:longest            " TAB auto-completion for file paths
set hidden                           " current buffer can be put into background
set showcmd                          " show incomplete commands
set noshowmode                       " don't show which mode disabled for PowerLine
set scrolloff=3                      " lines of text around cursor
set foldlevelstart=99                " all folds open by default
set cmdheight=1                      " command bar height
set autoread                         " detect when a file is changed
set noerrorbells
" set completeopt+=longest " Only insert the longest common text of the matches
set completeopt=menuone,preview " test

"set autowrite     " Automatically :write before running commands

" SPACES & TABS
" Explanations from http://tedlogan.com/techblog3.html
set tabstop=2     " How many columns a tab counts for
set softtabstop=2 " How many columns vim uses when pressing TAB in insert mode
set shiftwidth=2  " How many columns text is indented with << and >>
set noexpandtab   " Use tabs, not spaces
"set expandtab   " Use spaces
set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set autoindent    " Indent at the same level of the previous line
set smartindent   " Normally 'autoindent' should also be on when using 'smartindent'
"set shiftround    " round indent to a multiple of 'shiftwidth'

set ruler                " show the cursor position all the time
set nojoinspaces         " Prevents inserting two spaces after punctuation on a join (J)

" Searching
set ignorecase " case insensitive searching
set smartcase  " case-sensitive if expresson contains a capital letter
set hlsearch   " Highlight search terms
set incsearch  " set incremental search, like modern browsers
set lazyredraw " don't redraw while executing macros

" Highlight current line
" http://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim
set cursorline
" Highlight current line nr
"highlight cursorlinenr ctermbg=0 ctermfg=14
" highlight cursorlinenr ctermfg=14

" if textwidth > 80 highlight overlenght with reddish bg
set textwidth=80
highlight OverLength ctermbg=223 guibg=#592929
match OverLength /\%81v.\+/

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
"set spellfile=$HOME/.vim-spell-en.utf-8.add

" Open new split panes to right and bottom, which feels more natural
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" ctags
set tags=./tags;/

" Always use vertical diffs
set diffopt+=vertical

" Whitespaces
"set listchars=tab:‣\ ,eol:¬
set listchars=tab:»⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
" set showbreak=↪
" show invisible chars by default
"set list "use col by unimpaired

" backup/persistance settings
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backupskip=/tmp/*,/private/tmp/*"
set backup " delete old backup, backup current file
set undofile

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quick edit Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open vimrc
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>eV :tabnew ~/.vimrc<CR>
" edit vim plugins
nnoremap <leader>ep :e ~/.vimrc.plug<CR>
nnoremap <leader>eP :tabnew ~/.vimrc.plug<CR>
" edit vim local
nnoremap <leader>el :e ~/.vimrc.local<CR>
nnoremap <leader>eL :tabnew ~/.vimrc.local<CR>
" edit gitconfig
nnoremap <leader>eg :e ~/.gitconfig<CR>
nnoremap <leader>eG :tabnew ~/.gitconfig<CR>
" edit tmux.conf
nnoremap <leader>et :e ~/.tmux.conf<CR>
nnoremap <leader>eT :tabnew ~/.tmux.conf<CR>
" edit zshrc
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>eZ :tabnew ~/.zshrc<CR>

nnoremap <leader>ej :e ~/.vim/plugged/vim-snippets/UltiSnips/javascript.snippets<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General mappings/shortcuts for functionality
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" window killer | <Leader>bd used by qpkorr/vim-bufkill plugin
nnoremap <silent> <Leader>bh :call CloseWindowOrKillBuffer()<cr>

nnoremap <Leader>lo :lopen<cr>
nnoremap <Leader>co :copen<cr>
" nnoremap <Leader>cl :close<cr> " same as <C-w> c
nnoremap <Leader>cc :cclose<cr>
nnoremap <Leader>pc :pclose<cr> " same as <C-w> z
" quit all
nnoremap <Leader>! :qa<cr>
" quit all, ignore any changes
" nnoremap <Leader>qq :qa!<cr>

" shortcut to save/write
nnoremap <leader>w :w<cr>

" Map Ctrl + S to save in any mode
nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
"vnoremap <silent> <C-S> <C-C>:update<CR>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" reselect last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Search in visually selected block only
vnoremap / <Esc>/\%V\%V<Left><Left><Left>
vnoremap ? <Esc>?\%V\%V<Left><Left><Left>

vmap <leader>s :sort<cr>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <leader>, g<c-]>

" make Y consistent with C and D. See :help Y.
" YRRunAfterMaps takes care of this
nnoremap Y y$

" Switch to the directory of the open buffer
noremap <silent> <leader>cd :cd %:p:h<cr>

" remove trailing whitespace and clear the last search pattern
nnoremap <leader><space> :%s/\s\+$//<CR>:let @/=''<CR>

" toggle search highlighting: coh by unimpaired
"nmap <silent> <leader>/ :set invhlsearch<CR>

" toggle invisible characters: col by unimpaired
"nmap <leader>l :set list!<CR>

" switch between current and last buffer
" qpkorr/vim-bufkill provides :BA
nmap <leader>. <c-^>
" closes the current buffer before switching to the previous one
"noremap <leader>. <c-^> :bd #<cr>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>z :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>- :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
"nnoremap <silent> <Up> :resize +5<cr>
"nnoremap <silent> <Down> :resize -5<cr>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" toggle relativenumber: cor by unimpaired
" http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
"nnoremap <Leader>rn :set rnu!<ENTER>

" Buffer reload
nnoremap <Leader>rr :e!<CR>
nnoremap <Leader>ll :ls<CR>
"nnoremap <Leader>bn :bn<CR> "provided by unimpaired ]b
"nnoremap <Leader>bp :bp<CR> "provided by unimpaired [b
"
" Show Registers
nnoremap <Leader>rg :reg<CR>

" http://habrahabr.ru/post/183222/
" spell check on
nnoremap <Leader>sp :setlocal spell spelllang=ru_yo,en_us<ENTER>
" spell check off
nnoremap <Leader>spp :setlocal spell spelllang=<ENTER>

" Text Highlighter
nnoremap <silent> <leader>h0 :call HiInterestingWord(0)<cr>
nnoremap <silent> <leader>h1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>h2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>h3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>h4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>h5 :call HiInterestingWord(5)<cr>
nnoremap <leader>hh :call clearmatches()<CR>:noh<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => External cmd mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" find current word in quickfix
nnoremap <leader>f :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
" find last search in quickfix
nnoremap <leader>/ :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>
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
" AUTOCMD {{{
" ============================================================================

augroup vimrcEx
  autocmd!

  " automatically rebalance windows on vim resize
  " au VimResized * :wincmd =

	" Create directory if not exists
	" CTRLP plugin provides same functionality via <c-y>
	au BufWritePre * :silent !mkdir -p %:h

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  au BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  " au BufRead,BufNewFile Appraisals set filetype=ruby
  au BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  au FileType markdown setlocal spell spelllang=ru_yo,en_us

  " Automatically wrap at 80 characters for Markdown
  au BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  au FileType gitcommit setlocal textwidth=72
  au FileType gitcommit setlocal spell spelllang=ru_yo,en_us

  " Allow stylesheets to autocomplete hyphenated words
  au FileType css,scss,sass setlocal iskeyword+=-

  " js-beautify; ri = re-indent
  au FileType json noremap <buffer> <leader>ri <Esc>:% !js-beautify -f - -t<CR>
  au FileType html,xml noremap <buffer> <leader>ri <Esc>:% !html-beautify -f - -t<CR>
  au FileType css noremap <buffer> <leader>ri <Esc>:% !css-beautify -f - -t<CR>

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" ----------------------------------------------------------------------------
" Help in new tabs
" ----------------------------------------------------------------------------
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt call s:helptab()
augroup END

" }}}
" ============================================================================
" FUNCTIONS {{{
" ============================================================================

function! s:helptab()
  if &buftype == 'help'
    wincmd T
    nnoremap <buffer> q :q<cr>
  endif
endfunction

function! CloseWindowOrKillBuffer()
	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

	" never bdelete a nerd tree
	if matchstr(expand("%"), 'NERD') == 'NERD'
		wincmd c
		return
	endif

	if number_of_windows_to_this_buffer > 1
		wincmd c
	else
		bdelete
	endif
endfunction
" Text Highlighter
function! HiInterestingWord(n)
    " Save our location.
    normal! mz
    " Yank the current word into the z register.
    normal! "zyiw
    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n
    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)
    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'
    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)
    " Move back to our original location.
    normal! `z
endfunction

" Highlight colors constants
hi def InterestingWord0 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}
" ============================================================================
" vimrc.local BLOCK {{{
" ============================================================================

if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

" }}}
