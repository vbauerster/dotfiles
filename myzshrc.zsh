# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Guide/zshguide04.html
# http://www.geekmind.net/2011/01/shortcuts-to-improve-your-bash-zsh.html

export GOPATH=$HOME/gocode
export GEMPATH=$HOME/.gem/ruby/2.0.0

if [[ ! "$PATH" == *$GEMPATH/bin* ]]; then
  export PATH=$GEMPATH/bin:$PATH
fi

if [[ ! "$PATH" == *$GOPATH/bin* ]]; then
  export PATH=$GOPATH/bin:$PATH
fi

# check for custom bin directory and add to path
# if [[ ! "$PATH" == *~/bin* && -d ~/bin ]]; then
#     export PATH=~/bin:$PATH
# fi

# The time the shell waits, in hundredths of seconds, (default is 40)
# for another key to be pressed when reading bound multi-character sequences.
# 100ms for key sequences
export KEYTIMEOUT=10

# use the Dvorak keyboard for the basis for examining spelling mistakes 
setopt DVORAK

# no ^s freezing the screen
unsetopt flow_control

# history settings
setopt EXTENDED_HISTORY    # writes the history file in the *:start:elapsed;command* format
setopt INC_APPEND_HISTORY  # writes to the history file immediately, not when the shell exits
setopt HIST_IGNORE_DUPS    # does not record an event that was just recorded again.
setopt HIST_SAVE_NO_DUPS   # does not write a duplicate event to the history file
setopt HIST_IGNORE_SPACE   # does not record an event starting with a space
SAVEHIST=4096
HISTSIZE=4096              # stores the maximum number of events to save in the internal history

# Bindings
# http://zsh.sourceforge.net/Intro/intro_11.html#SEC11 
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# ctrl + enter = accept-and-hold
bindkey '^[[13;5u' accept-and-hold
# in vi mode use j/k for history-substring search
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey '^[OA' up-line-or-history
bindkey '^[OB' down-line-or-history
bindkey '^ ' autosuggest-accept

# following just for reference
# ^Q push-line-or-edit
# ^U vi-kill-line
# ^W vi-backward-kill-word
# ^H vi-backward-delete-char
# ^I fzf-completion
# ^T fzf-file-widget
# ^R fzf-history-widget
# ^[c fzf-cd-widget = alt+c

# history-incremental is from editor module
# in vi mode / = history-incremental-search-forward
# in vi mode ? = history-incremental-search-backward

# bindkey '^S' insert-last-word
# bindkey -M vicmd "u" undo
# bindkey -M vicmd "ga" what-cursor-position

# fzf bindings
# first unbind '^G', which is bound to list-expand by default
bindkey '^G' undefined-key
bindkey '^Gt' fzf-gt-widget
bindkey '^Gh' fzf-gh-widget

# https://github.com/kurkale6ka/zsh/blob/master/.zshrc 
### ^x0 IPs
bindkey -s '^x0' '127.0.0.1'
bindkey -s '^x1' '10.0.0.'
bindkey -s '^x7' '172.16.0.'
bindkey -s '^x9' '192.168.0.'

### ^x_ /dev/null
bindkey -s '^x_' '/dev/null'

# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

if [ -z "$BACKGROUND" ]; then
    export BACKGROUND="dark"
fi

# set the background color to light
function light() {
    export BACKGROUND="light"
}

function dark() {
    export BACKGROUND="dark"
}

# searches the current directory subtree for files with names containing a
# string (ignoring case). f png would find all PNG files in the current subtree,
# as well as “PNGisMyFavorite.txt” and so forth.
# function f() { find . -iname "*$1*" ${@:2} }
# function f() { ag -l --nocolor -u -g "$1" ${@:2} }
# recursively greps the current directory subtree for files matching a pattern.
# r HTTP would grep for files containing that exact string, while r
# '"http[^"]*"' -i would search for double-quoted strings starting with “http”,
# ignoring case.
# conflicts with zsh r command
#function r() { grep -rn "$1" ${@:2} . }

# print available colors and their numbers
function colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
