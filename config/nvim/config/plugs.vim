call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'morhetz/gruvbox'
" The colorscheme with neovim in mind
" Plug 'freeo/vim-kalisi'

" Essential
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'vbauerster/vim-unimpaired', { 'branch': 'pdvorak' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Plug 'fszymanski/fzf-gitignore.nvim', {'do': ':UpdateRemotePlugins'}

" Motions
Plug 'justinmk/vim-sneak'

" UI look and feel
Plug 'vim-airline/vim-airline-themes' | Plug 'vim-airline/vim-airline'
" Plug 'bling/vim-bufferline'
" Plug 'ryanoasis/vim-devicons'
" Plug 'itchyny/lightline.vim'

" Marks
Plug 'kshenoy/vim-signature'

" Grep like search
" Plug 'mhinz/vim-grepper'
" Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" General Programming
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'neomake/neomake'
" Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'tpope/vim-commentary'
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'FooSoft/vim-argwrap'    " Wrap a paremeter list accross multiple lines
Plug 'tommcdo/vim-exchange'   " cx to exchange
Plug 'chaoren/vim-wordmotion' " CamelCase motion
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'othree/eregex.vim'

" Git
Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim' | Plug 'tpope/vim-rhubarb'
" Plug 'SevereOverfl0w/deoplete-github'
Plug 'airblade/vim-gitgutter'
" Make gists easily from Vim
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'airblade/vim-rooter'

" AutoComplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" neco-syntax: syntax files as completion source
Plug 'Shougo/neco-syntax'
" neco-vim: 'vim' source for Vim script
Plug 'Shougo/neco-vim'
" context_filetype: It adds the context filetype feature
Plug 'Shougo/context_filetype.vim'
" echodoc: It prints the documentation you have completed
Plug 'Shougo/echodoc.vim'
" neoinclude: 'include' and 'file/include' sources
" You can completes the candidates from the included files and included path
Plug 'Shougo/neoinclude.vim'
" deoplete-go: 'golang' source
Plug 'zchee/deoplete-go', { 'for': ['go'], 'do': 'make'}
" deoplete-clang: 'clang' source for C/C++
" Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
" deoplete-ternjs: 'ternjs' source for JavaScript
Plug 'carlitux/deoplete-ternjs', {'for': ['javascript', 'jsx'], 'do': 'npm install -g tern' }
" neco-look: plugin for /usr/bin/look for completing words in English
Plug 'ujihisa/neco-look', { 'for': ['markdown', 'gitcommit'] }
" tmux-complete: 'tmuxcomplete' source for tmux panes
Plug 'wellle/tmux-complete.vim'
" UltiSnips source: 'ultisnips' source for UltiSnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Golang
Plug 'fatih/vim-go', {'for': ['go'] }
Plug 'jodosha/vim-godebug', {'for': ['go'] }

" Java
Plug 'artur-shaik/vim-javacomplete2', {'for': ['java'] }

" Auto pairs
Plug 'vbauerster/auto-pairs', { 'branch': 'pumvisible' }
" Plug 'Raimondi/delimitMate'

" HTML
" Plug 'docunext/closetag.vim' "close HTML tag
" Plug 'amirh/HTML-AutoCloseTag'
Plug 'valloric/MatchTagAlways', {'for': ['html'] }
Plug 'suan/vim-instant-markdown', { 'for': ['markdown'] }

" Emmet
Plug 'mattn/emmet-vim'

" Extended session management for Vim
" Plug 'vim-scripts/sessionman.vim'
" Plug 'xolox/vim-session'
Plug 'tpope/vim-obsession'

" Syntax
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'

" JavaScript
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
" Plug 'maksimr/vim-jsbeautify', {'for': ['javascript', 'json', 'css', 'html'] }
" Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
" Plug 'burnettk/vim-angular'

" Typescript
" Plug 'HerringtonDarkholme/yats.vim' " Syntax

" CoffeScript
" Plug 'kchmck/vim-coffee-script' " Syntax

" c/cpp
" Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] }

" Misc.
" Plug 'chrisbra/Colorizer'
Plug 'ap/vim-css-color'
Plug 'lyokha/vim-xkbswitch'
Plug 'tyru/open-browser.vim'
Plug 'romainl/vim-qf'
Plug 'blueyed/vim-qf_resize'
Plug 'tpope/vim-characterize' " enhaced ga
Plug 'tpope/vim-capslock'     " <C-G>c in insert mode
Plug 'wesQ3/vim-windowswap'   " <leader>ww to swap windows
Plug 'justinmk/vim-gtfo'      " got/gof mappings

if has('mac')
  Plug 'rizzatti/dash.vim'
endif

" Clipboard related
Plug 'junegunn/vim-peekaboo'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux'

" my plugins
" Plug 'vbauerster/vim-vjump'
" Plug 'vbauerster/vim-highlighter'

" Plug 'cosminadrianpopescu/vim-sql-workbench'

" Add plugins to &runtimepath
call plug#end()
