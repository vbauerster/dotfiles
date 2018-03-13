# dracula theme
# https://draculatheme.com/

%sh{
    black="rgb:282a36"
    gray="rgb:44475a"
    white="rgb:f8f8f2"

    pink="rgb:ff79c6"
    purple="rgb:bd93f9"
    blue="rgb:6272a4"
    cyan="rgb:8be9fd"
    green="rgb:50fa7b"
    yellow="rgb:f1fa8c"
    orange="rgb:ffb86c"
    red="rgb:ff5555"

    echo "
         face value $green
         face type $purple
         face variable $red
         face function $red
         face module $red
         face string $yellow
         face error $red
         face keyword $cyan
         face operator $orange
         face attribute $pink
         face comment $blue+i
         face meta $red
         face builtin $white+b

         face title $red
         face header $orange
         face bold $pink
         face italic $purple
         face mono $green
         face block $cyan
         face link $green
         face bullet $green
         face list $white

         face Default $white,$black
         face PrimarySelection $black,$pink
         face SecondarySelection $black,$purple
         face PrimaryCursor $black,$cyan
         face SecondaryCursor $black,$orange
         face MatchingChar $black,$blue
         face Search $blue,$green
         face CurrentWord $white,$blue

         # listchars
         face Whitespace $gray,$black
         # ~ lines at EOB
         face BufferPadding $gray,$black

         face LineNumbers $gray,$black
         # must use -hl-cursor
         face LineNumberCursor $white,$gray+b

         # when item focused in menu
         face MenuForeground $blue,$white
         # default bottom menu and autocomplete
         face MenuBackground $white,$blue
         # complement in autocomplete like path
         face MenuInfo $cyan,$blue
         # clippy
         face Information $yellow,$black
         face Error $black,$red

         # all status line: what we type, but also client@[session]
         face StatusLine $white,$black
         # insert mode, prompt mode
         face StatusLineMode $black,$green
         # message like '1 sel'
         face StatusLineInfo $purple,$black
         # count
         face StatusLineValue $orange,$black
         face StatusCursor $white,$blue
         # like the word 'select:' when pressing 's'
         face Prompt $black,$green
    "
}
