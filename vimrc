"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set a map leader for more key combos
let mapleader = ','

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
" shorter escape delay
set timeoutlen=700 ttimeoutlen=100
"set title " set terminal title
"set so=7 " set 7 lines to the cursors - when moving vertical
set wildmenu              " enhanced command line completion
set wildmode=list:longest " complete files like a shell
set wildignore+=*.o,*.obj,.git,node_modules,_site,*.class,*.zip,*.aux
set hidden                " current buffer can be put into background
set showcmd               " show incomplete commands
set noshowmode            " don't show which mode disabled for PowerLine
set scrolloff=3           " lines of text around cursor
set foldlevelstart=99     " all folds open by default
set cmdheight=1           " command bar height
set pastetoggle=<F2>      " F2 before pasting to preserve indentation
set autoread              " detect when a file is changed
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
set history=256
set undolevels=256

" make backspace behave in a sane manner
set backspace=indent,eol,start
"set backspace=2   " Backspace deletes like most programs in insert mode
"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
"set autowrite     " Automatically :write before running commands

" Softtabs, 4 spaces
set expandtab       " Tabs are spaces, not tabs
set smarttab        " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set shiftwidth=4    " Use indents of 4 spaces
set softtabstop=4   " Let backspace delete indent
set tabstop=4       " An indentation every four columns
set autoindent      " Indent at the same level of the previous line
set ruler           " show the cursor position all the time
set shiftround      " round indent to a multiple of 'shiftwidth'
set smartindent
set nojoinspaces    " Prevents inserting two spaces after punctuation on a join (J)
"set completeopt+=longest

" Searching
set ignorecase " case insensitive searching
set smartcase  " case-sensitive if expresson contains a capital letter
set hlsearch   " Highlight search terms
set incsearch  " set incremental search, like modern browsers
set lazyredraw " don't redraw while executing macros

"highlight search ctermfg=white ctermbg=3423513
"highlight search ctermfg=white ctermbg=none

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
set listchars=tab:»⋅,trail:⋅,nbsp:⋅,extends:❯,precedes:❮
set showbreak=↪
" show invisible chars by default
set list

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
nnoremap Q ZQ
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

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <leader>g g<c-]>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Switch to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>

" remove trailing whitespace and clear the last search pattern
nnoremap <leader><space> :%s/\s\+$//<CR>:let @/=''<CR>

" toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>

" toggle invisible characters
nmap <leader>c :set list!<CR>

" switch between current and last buffer
nmap <leader>. <c-^>
" closes the current buffer before switching to the previous one
"noremap <leader>q <c-^> :bd #<cr>

" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" Easier split navigations
" Looks like tmux.conf manages this
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" scroll the viewport faster
"nnoremap <C-e> 3<C-e>
"nnoremap <C-y> 3<C-y>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" bind K to Ag word under cursor
"nnoremap K :Ag! "<C-R><C-W>"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COOL THINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif

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

"highlight search ctermfg=gray ctermbg=black
"highlight search ctermfg=gray

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Local config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local config if available {
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
" }
