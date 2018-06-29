# seagull theme
# https://github.com/nightsense/seabird

%sh{
    black="rgb:1d252b"
    gray="rgb:121213"
    lightgray="rgb:4078C0"
    white="rgb:F8F8FF"

    pink="rgb:ff549b"
    purple="rgb:9854ff"
    blue="rgb:0099ff"
    cyan="rgb:00a5ab"
    green="rgb:11ab00"
    yellow="rgb:F8F8FF"
    orange="cyan"
    red="blue"

    echo "
         face global value $green
         face global type $purple
         face global variable $red
         face global function $red
         face global module $red
         face global string $yellow
         face global error $red
         face global keyword $cyan
         face global operator $orange
         face global attribute $pink
         face global comment $blue
         face global meta $red
         face global builtin $black

         face global title $red
         face global header $orange
         face global bold $pink
         face global italic $purple
         face global mono $green
         face global block $cyan
         face global link $green
         face global bullet $green
         face global list $gray

         face global Default $gray,$white

         face global PrimarySelection $black,$pink
         face global PrimaryCursor $black,$blue
         face global PrimaryCursorEol $black,$blue

         face global SecondarySelection $black,$purple
         face global SecondaryCursor $black,$orange
         face global SecondaryCursorEol $black,$orange

         face global MatchingChar $black,$cyan
         face global Search $blue,$green
         face global CurrentWord $gray,$lightgray

         # listchars
         face global Whitespace $lightgray,$white
         # ~ lines at EOB
         face global BufferPadding $lightgray,$white

         face global LineNumbers $gray,$white
         # must use -hl-cursor
         face global LineNumberCursor $black,$white+b
         face global LineNumbersWrapped $gray,$white+i

         # when item focused in menu
         face global MenuForeground $blue,$white+b
         # default bottom menu and autocomplete
         face global MenuBackground $white,$blue
         # complement in autocomplete like path
         face global MenuInfo $lightgray,$blue
         # clippy
         face global Information $yellow,$lightgray
         face global Error $black,$red

         # all status line: what we type, but also client@[session]
         face global StatusLine $black,$white
         # insert mode, prompt mode
         face global StatusLineMode $white,$green
         # message like '1 sel'
         face global StatusLineInfo $purple,$white
         # count
         face global StatusLineValue $orange,$white
         face global StatusCursor $white,$blue
         # like the word 'select:' when pressing 's'
         face global Prompt $white,$green
    "
}
