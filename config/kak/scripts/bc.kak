# https://github.com/mawww/kakoune/wiki/Bc
# Incrementing / decrementing numbers
define-command -hidden -params 2 inc %{
    evaluate-commands %sh{
        if [ "$1" = 0 ]
        then
            count=1
        else
            count="$1"
        fi
        printf '%s%s\n' 'exec h"_/\d<ret><a-i>na' "$2($count)<esc>|bc<ret>h"
    }
}
map global normal <c-a> ':inc %val{count} +<ret>'
map global normal <c-x> ':inc %val{count} -<ret>'
