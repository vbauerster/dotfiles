# seagull theme
# https://github.com/nightsense/seabird

%sh{
    black="rgb:1d252b"
    gray="rgb:6d767d"
    lightgray="rgb:e6eaed"
    white="rgb:ffffff"

    pink="rgb:ff549b"
    purple="rgb:9854ff"
    blue="rgb:0099ff"
    cyan="rgb:00a5ab"
    green="rgb:11ab00"
    yellow="rgb:bf8c00"
    orange="rgb:ff6200"
    red="rgb:ff4053"

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
         face comment $blue
         face meta $red
         face builtin $black

         face title $red
         face header $orange
         face bold $pink
         face italic $purple
         face mono $green
         face block $cyan
         face link $green
         face bullet $green
         face list $gray

         face Default $gray,$white
         face PrimarySelection $black,$pink
         face SecondarySelection $black,$purple
         face PrimaryCursor $black,$blue
         face SecondaryCursor $black,$orange
         face MatchingChar $black,$cyan
         face Search $blue,$green
         face CurrentWord $gray,$lightgray

         # listchars
         face Whitespace $lightgray,$white
         # ~ lines at EOB
         face BufferPadding $lightgray,$white

         face LineNumbers $gray,$white
         # must use -hl-cursor
         face LineNumberCursor $black,$white+b

         # when item focused in menu
         face MenuForeground $blue,$white
         # default bottom menu and autocomplete
         face MenuBackground $white,$blue
         # complement in autocomplete like path
         face MenuInfo $lightgray,$blue
         # clippy
         face Information $yellow,$white
         face Error $black,$red

         # all status line: what we type, but also client@[session]
         face StatusLine $black,$white
         # insert mode, prompt mode
         face StatusLineMode $white,$green
         # message like '1 sel'
         face StatusLineInfo $purple,$white
         # count
         face StatusLineValue $orange,$white
         face StatusCursor $white,$blue
         # like the word 'select:' when pressing 's'
         face Prompt $white,$green
    "
}
