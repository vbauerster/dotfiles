"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set a map leader for more key combos
let mapleader = ','
let maplocalleader = ','

"set nocompatible " not compatible with vi
set encoding=utf-8

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }

if has('clipboard')
		if has('unnamedplus')  " When possible use + register for copy-paste
				set clipboard=unnamed,unnamedplus
		else         " On mac and Windows, use * register for copy-paste
				set clipboard=unnamed
		endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" OS X
set wildignore+=*.DS_Store
" Binary images
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
" Excluding node_modules
"set wildignore+=*/node_modules/*

set dictionary=/usr/share/dict/words " CTRL-X CTRL-K to autocomplete
set timeoutlen=800 ttimeoutlen=100   " shorter escape delay
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
set shell=$SHELL

" backup/persistance settings
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backupskip=/tmp/*,/private/tmp/*"
set backup
set writebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" persist (g)undo tree between sessions
set undofile
if !has('nvim') " sets for vim only
	set pastetoggle=<F2> " https://github.com/neovim/neovim/issues/2092
	set history=1000     " nvim sets this to 1000 by default
	set undolevels=1000  " nvim sets this to 1000 by default
endif

" make backspace behave in a sane manner
set backspace=indent,eol,start
"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
"set autowrite     " Automatically :write before running commands

" SPACES & TABS
" Explanations from http://tedlogan.com/techblog3.html
set tabstop=2     " How many columns a tab counts for
set softtabstop=2 " How many columns vim uses when pressing TAB in insert mode
set shiftwidth=2  " How many columns text is indented with << and >>
"set noexpandtab   " Don't insert spaces when pressing TAB
set smarttab      " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set autoindent    " Indent at the same level of the previous line
set smartindent   " Normally 'autoindent' should also be on when using 'smartindent'
"set shiftround    " round indent to a multiple of 'shiftwidth'

set ruler                " show the cursor position all the time
set nojoinspaces         " Prevents inserting two spaces after punctuation on a join (J)
set completeopt+=longest " Only insert the longest common text of the matches

" Searching
set ignorecase " case insensitive searching
set smartcase  " case-sensitive if expresson contains a capital letter
set hlsearch   " Highlight search terms
set incsearch  " set incremental search, like modern browsers
set lazyredraw " don't redraw while executing macros

" Color scheme
syntax on
"set background=dark
execute "set background=".$BACKGROUND
colorscheme solarized

" Highlight current line
set cursorline

" if textwidth > 120 highlight overlenght with reddish bg
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" Make it obvious where 120 characters is
set textwidth=120
"set colorcolumn=+1
"highlight colorcolumn ctermbg=gray guibg=orange

" Numbers
set number
set numberwidth=5

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
"set spellfile=$HOME/.vim-spell-en.utf-8.add

" Open new split panes to right and bottom, which feels more natural
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

set tags=./tags;/,~/.vimtags

" Always use vertical diffs
set diffopt+=vertical

" Whitespaces
set listchars=tab:‣\ ,eol:¬
"set listchars=tab:»⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
set showbreak=↪
" show invisible chars by default
"set list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => StatusLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show the satus line all the time
set laststatus=2
" Broken down into easily includeable segments
"set statusline=%<%f\                     " Filename
"set statusline+=%w%h%m%r                 " Options
"set statusline+=%{fugitive#statusline()} " Git Hotness
"set statusline+=\ [%{&ff}/%Y]            " filetype
"set statusline+=\ [%{getcwd()}]          " current dir
"set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quick edit Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open vimrc
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>eV :tabnew ~/.vimrc<CR>
" edit vim plugins
nnoremap <leader>eb :e ~/.vimrc.bundles<CR>
nnoremap <leader>eB :tabnew ~/.vimrc.bundles<CR>
" edit vim local
nnoremap <leader>el :e ~/.vimrc.local<CR>
nnoremap <leader>eL :tabnew ~/.vimrc.local<CR>
" edit gitconfig
nnoremap <leader>eg :e ~/.gitconfig<CR>
nnoremap <leader>eG :tabnew ~/.gitconfig<CR>
" edit tmux.conf
nnoremap <leader>et :e ~/.tmux.conf<CR>
nnoremap <leader>eT :tabnew ~/.tmux.conf<CR>

nnoremap <leader>ej :e ~/.vim/bundle/vim-snippets/UltiSnips/javascript.snippets<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General mappings/shortcuts for functionality
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" close current buffer without save
nnoremap QQ ZQ
" quit all
nnoremap <Leader>q :qa<cr>

" reload ctags, --fields=+l needs by YCM
nnoremap <leader>ct :!/usr/local/bin/ctags -R --fields=+l --exclude=.git --exclude=log --exclude=tmp *<CR><CR>

" shortcut to save/write
nnoremap <leader>w :w!<cr>

" Map Ctrl + S to save in any mode
nnoremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Retain visual mode after indentation shifts
vnoremap < <gv
vnoremap > >gv
" Search in visually selected block only
vnoremap / <Esc>/\%V\%V<Left><Left><Left>
vnoremap ? <Esc>?\%V\%V<Left><Left><Left>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" upercase previous word in insert mode
map! <leader>t <Esc>gUiw']a

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <leader>g g<c-]>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Switch to the directory of the open buffer
noremap <silent> <leader>cd :cd %:p:h<cr>

" remove trailing whitespace and clear the last search pattern
nnoremap <leader><space> :%s/\s\+$//<CR>:let @/=''<CR>

" toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>

" toggle invisible characters
nmap <leader>l :set list!<CR>

" switch between current and last buffer
nmap <leader>. <c-^>
" closes the current buffer before switching to the previous one
"noremap <leader>. <c-^> :bd #<cr>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" ,f
" Fast grep
" Recursive search in current directory for matches with current word
nnoremap <Leader>f :<C-u>execute "Ag " . expand("<cword>") <Bar> cw<CR>

" toggle relativenumber
" http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
nnoremap <Leader>rn :set rnu!<ENTER>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COOL THINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Create directory if not exists
" CTRLP plugin provides same functionality via <c-y>
au! BufWritePre * :silent !mkdir -p %:h

" http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
let s:_ = ''

function! s:ExecuteInShell(command, bang)
	let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))

	if (_ != '')
		let s:_ = _
		let bufnr = bufnr('%')
		let winnr = bufwinnr('^' . _ . '$')
		silent! execute  winnr < 0 ? 'belowright new ' . fnameescape(_) : winnr . 'wincmd w'
		setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number
		silent! :%d
		let message = 'Execute ' . _ . '...'
		call append(0, message)
		echo message
		silent! 2d | resize 1 | redraw
		silent! execute 'silent! %!'. _
		silent! execute 'resize ' . line('$')
		silent! execute 'syntax on'
		silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
		silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
		silent! execute 'nnoremap <silent> <buffer> <CR> :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
		silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
		silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
		nnoremap <silent> <buffer> <C-W>_ :execute 'resize ' . line('$')<CR>
		silent! syntax on
	endif
endfunction

command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
cabbrev shell Shell

nnoremap <leader>nn :Shell node --harmony %<CR>

augroup vimrcEx
  autocmd!

  " automatically rebalance windows on vim resize
  "autocmd VimResized * :wincmd =

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Text Highlighter = <leader>h[1-4]
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

nnoremap <leader>hh :call clearmatches()<CR>:noh<CR>
nnoremap <silent> <leader>h1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>h2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>h3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>h4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>h5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>h6 :call HiInterestingWord(6)<cr>

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

"custom search (*) hightlight
if $BACKGROUND == 'dark'
	highlight search ctermfg=16 ctermbg=137
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Local config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local config if available {
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
" }
