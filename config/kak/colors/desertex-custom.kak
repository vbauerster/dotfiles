# desertex theme

# Code
face global value      rgb:fa8072
face global type       rgb:dfdfbf
face global identifier rgb:87ceeb
face global string     rgb:fa8072
face global error      rgb:c3bf9f+b
face global keyword    rgb:eedc82
face global operator   rgb:87ceeb
face global attribute  rgb:eedc82
face global comment    rgb:7ccd7c+i

# #include <...>
face global meta rgb:ee799f

# Markup
face global title  blue
face global header cyan
face global bold   red
face global italic yellow
face global mono   green
face global block  magenta
face global link   cyan
face global bullet cyan
face global list   yellow

# Builtin
# fg,bg+attributes
# face global Default default,rgb:262626 <- change the terminal bg color instead
face global Default default,default

face global PrimarySelection   white,blue
face global SecondarySelection black,blue

face global PrimaryCursor   black,white
face global SecondaryCursor black,white

face global PrimaryCursorEol   black,rgb:7ccd7c
face global SecondaryCursorEol black,rgb:7ccd7c

face global LineNumbers      rgb:605958
face global LineNumberCursor yellow,default+b

# Bottom menu:
# text + background
face global MenuBackground black,rgb:c2bfa5+b
# selected entry in the menu (use 302028 when true color support is fixed)
face global MenuForeground rgb:f0a0c0,magenta

# completion menu info
face global MenuInfo white,rgb:445599

# assistant, [+]
face global Information black,yellow

face global Error      white,red
face global StatusLine cyan,default

# Status line modes and prompts:
# insert, prompt, enter key...
face global StatusLineMode rgb:ffd75f,default

# 1 sel
face global StatusLineInfo blue,default

# param=value, reg=value. ex: "ey
face global StatusLineValue green,default

face global StatusCursor black,cyan

# :
face global Prompt blue

# (), {}
face global MatchingChar cyan+b

# EOF tildas (~)
face global BufferPadding blue,default
