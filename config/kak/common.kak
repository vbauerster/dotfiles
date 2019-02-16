## General settings.
set-option global ui_options ncurses_status_on_top=true ncurses_assistant=off
set-option global tabstop 4
set-option global indentwidth 4
# keep space around cursor
set-option global scrolloff 2,2
# fix for https://github.com/mawww/kakoune/issues/2020
set-option global disabled_hooks .*-trim-indent
try %{ set global grepcmd 'ag --filename --column --ignore tags --ignore build --ignore buildDebug' }

# Use main client as jumpclient
# set-option global jumpclient client0

colorscheme github-custom

hook global WinCreate .* %{
    add-highlighter window/numbers    number-lines -hlcursor -separator ' '
    add-highlighter window/matching   show-matching
    add-highlighter window/show-whitespaces show-whitespaces -tab '›' -tabpad '⋅' -spc ' ' -nbsp '⍽'
    add-highlighter window/wrap       wrap -word -indent -marker ↪
    add-highlighter window/VisibleWords regex \b(?:FIXME|TODO|XXX)\b 0:default+rb

    tab-completion-enable
    # show-trailing-whitespace-enable; face window TrailingWhitespace default,red
    search-highlighting-enable; face window Search default,rgb:EDF97D+bi
}

# escape hatch
# https://github.com/mawww/kakoune/wiki/Avoid-the-escape-key
hook global InsertChar \. %{ try %{
    exec -draft hH <a-k>,\.<ret> d
    exec <esc>
}}

alias global u enter-user-mode

## Maps.
map global normal <F2> ': w<ret>' -docstring 'save'
map global normal 'q' <space>
map global normal <a-q> <a-space>
# space is my leader
map global normal <space> ','
map global user <space> ':' -docstring 'command prompt'
map global normal ':' '%' -docstring 'select whole buffer'

# https://github.com/mawww/kakoune/wiki/Selections#how-to-make-x-select-lines-downward-and-x-select-lines-upward
map global normal x ': extend-line-down %val{count}<ret>'
map global normal X ': extend-line-up %val{count}<ret>'

# Save position before %
map global normal <%> '<c-s>%'
map global normal = <a-`> -docstring 'toggle case'

map global normal <#>   ': comment-line<ret>' -docstring 'comment line'
map global normal <a-#> ': comment-block<ret>' -docstring 'comment block'

# stop c and d from yanking
# map global normal d <a-d>
# map global normal c <a-c>
# map global normal <a-d> ''
# map global normal <a-c> ''

map global normal <'> <">
map global normal <"> <q>

# https://github.com/mawww/kakoune/issues/1791
# map global object q Q -docstring 'double quote string'
# map global object Q q -docstring 'single quote string'
map global view u t -docstring 'same as t'
map global view h hv
map global view j jv
map global view k kv
map global view l lv

map -docstring 'print working dir' global user '.' ': print-working-directory<ret>'
map -docstring 'Reload buffer'     global user R ': e!<ret>'
map -docstring 'man'               global user k ': smart-select word; man-selection-with-count<ret>'

map global normal <0> ': zero select-or-add-cursor<ret>'
map global normal <*> ': smart-select word<ret>*'

## Spell
declare-user-mode spell
map -docstring "next error"      global spell 'n' ': spell-next<ret>'
map -docstring "replace word"    global spell 'r' '_: spell-replace<ret>'
map -docstring "exit spell mode" global spell 'c' ': spell-clear<ret>'
map -docstring "spell mode"      global user  'S' ': enter-user-mode -lock spell; spell en-US<ret>'

declare-user-mode search
map -docstring 'regex disabled'   global search / ': exec /<ret>\Q\E<left><left>'
map -docstring 'case insensitive' global search i '/(?i)'
map -docstring 'select all'       global search a ': smart-select word<ret>*%s<ret>'
map -docstring 'search mode'      global user / ': enter-user-mode search<ret>'

## Goto
map -docstring 'last buffer change'             global goto ';' '.'
map -docstring 'switch to [+] buffer'           global goto <plus> '<esc>: switch-to-modified-buffer<ret>'
map -docstring "file non-recursive"             global goto <a-f> '<esc>gf'
map -docstring "file recursive"                 global goto 'f' '<esc>: smart-select; search-file %val{selection}<ret>'
map -docstring "search tag in current file"     global goto '[' '<esc>: smart-select word; symbol<ret>'
map -docstring "search tag in global tags file" global goto ']' '<esc>: smart-select word; ctags-search<ret>'

## System clipboard
declare-user-mode clipboard
map -docstring 'yank to tmux buffer'              global clipboard Y '<a-|>tmux setb -b kak "$kak_selection"<ret>'
map -docstring 'yank to sysclipboard'             global clipboard y '<a-|>pbcopy<ret>'
map -docstring 'paste (insert) from sysclipboard' global clipboard p '!pbpaste<ret>'
map -docstring 'paste (append) from sysclipboard' global clipboard P '<a-!>pbpaste<ret>'
map -docstring 'import from sysclipboard'         global clipboard i ': clipboard-import<ret>'
map -docstring 'export to sysclipboard'           global clipboard e ': clipboard-export<ret>'
map -docstring 'clipboard mode'                   global normal Y ': enter-user-mode clipboard<ret>'

declare-user-mode anchor
map global anchor <,>     ': slice-by-camel<ret>'    -docstring 'slice by word'
map global anchor <minus> ': shrink-selection<ret>'  -docstring 'shrink selection'
map global anchor <plus>  ': enlarge-selection<ret>' -docstring 'enlarge selection'
map global anchor <space> ': expand<ret>'            -docstring 'smart expand'
map global anchor a       '<a-;>;'                   -docstring 'reduce to anchor'
map global anchor c       ';'                        -docstring 'reduce to cursor'
map global anchor f       '<a-;>'                    -docstring 'flip cursor and anchor'
map global anchor h       '<a-:><a-;>'               -docstring 'ensure anchor after cursor'
map global anchor l       '<a-:>'                    -docstring 'ensure cursor after anchor'
map global anchor s       '<a-S>'                    -docstring 'select cursor and anchor'

map global normal <,> ': enter-user-mode  anchor<ret>'
map global normal <a-,> ': enter-user-mode -lock anchor<ret>'

declare-user-mode echo-mode
map -docstring 'opt'                  global echo-mode o ':echo %opt{}<left>'
map -docstring 'opt debug'            global echo-mode O ':echo -debug %opt{}<left>'
map -docstring 'reg'                  global echo-mode r ':echo %reg{}<left>'
map -docstring 'reg debug'            global echo-mode R ':echo -debug %reg{}<left>'
map -docstring 'sh'                   global echo-mode s ':echo %sh{}<left>'
map -docstring 'sh debug'             global echo-mode S ':echo -debug %sh{}<left>'
map -docstring 'val'                  global echo-mode v ':echo %val{}<left>'
map -docstring 'val debug'            global echo-mode V ':echo -debug %val{}<left>'
map -docstring 'ModeChange debug on'  global echo-mode m ': hook -group echo-mode window ModeChange .* %{ echo -debug ModeChange %val{hook_param} }<ret>'
map -docstring 'ModeChange debug off' global echo-mode M ': rmhooks window echo-mode<ret>'
map -docstring 'echo mode'            global user e ': enter-user-mode echo-mode<ret>'

declare-user-mode git
map global git b  ': git-toggle-blame<ret>'       -docstring 'blame (toggle)'
map global git l  ': git log<ret>'                -docstring 'log'
map global git c  ': git commit<ret>'             -docstring 'commit'
map global git d  ': git diff<ret>'               -docstring 'diff'
map global git s  ': git status<ret>'             -docstring 'status'
map global git h  ': git show-diff<ret>'          -docstring 'show diff'
map global git H  ': git-hide-diff<ret>'          -docstring 'hide diff'
map global git w  ': git-show-blamed-commit<ret>' -docstring 'show blamed commit'
map global git L  ': git-log-lines<ret>'          -docstring 'log blame'
map global user g ': enter-user-mode git<ret>'    -docstring 'git mode'

# Insert mode
# <c-o>    ; # silent: stop completion
# <c-x>    ; # complete here
# <c-v>    ; # raw insert, use vim binding
map global insert <c-y> '<a-;>!pbpaste<ret>'

# https://github.com/mawww/kakoune/wiki/Selections#how-to-make-word-keys-discern-camelcase-or-snake_case-parts
# define-command -hidden select-prev-word-part %{
#   exec <a-/>[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
# }
# define-command -hidden select-next-word-part %{
#   exec /[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
# }
# define-command -hidden extend-prev-word-part %{
#   exec <a-?>[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
# }
# define-command -hidden extend-next-word-part %{
#   exec ?[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
# }

# <a-_> merge contiguous selections together (works across lines as well)
