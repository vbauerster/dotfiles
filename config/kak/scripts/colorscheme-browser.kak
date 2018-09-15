# Cycle through colorschemes quickly to find a nice one.

# Apparently there's no way to find the current colorscheme.
decl -hidden int colorscheme_index 0
def -hidden colorscheme-change -params 1 %{ eval %sh{
    # From share/kak/kakrc:
    colorschemes=$(find -L "${kak_runtime}/colors" "${kak_config}/colors" -type f -name '*\.kak' \
      2>/dev/null | while read -r filename; do
        basename="${filename##*/}"
        printf %s\\n "${basename%.*}"
      done | tr '\n' ' ')

    delta=1
    [ "$1" = prev ] && delta=-1
    count="$(echo "$colorschemes" | wc -w)"
    new_index=$(((kak_opt_colorscheme_index + count + delta - 1) % count + 1))
    new_colorscheme=$(echo "$colorschemes" | cut -d' ' -f $new_index)
    echo "set window colorscheme_index $new_index"
    echo "colorscheme $new_colorscheme"
    echo "echo colorscheme $new_index: $new_colorscheme"
}}

declare-user-mode colorscheme-browser
map global colorscheme-browser [ ': colorscheme-change prev<ret>' -docstring 'previous'
map global colorscheme-browser ] ': colorscheme-change next<ret>' -docstring 'next'
def colorscheme-browser %{ enter-user-mode -lock colorscheme-browser }
