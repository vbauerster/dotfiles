export DOTFILES=$HOME/dotfiles
export GOPATH=$HOME/goprojects

if [[ ! "$PATH" == *$DOTFILES/bin* ]]; then
  export PATH=$DOTFILES/bin:$PATH
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

# history settings
setopt EXTENDED_HISTORY    # writes the history file in the *:start:elapsed;command* format
setopt INC_APPEND_HISTORY  # writes to the history file immediately, not when the shell exits
setopt HIST_IGNORE_DUPS    # does not record an event that was just recorded again.
setopt HIST_SAVE_NO_DUPS   # does not write a duplicate event to the history file
setopt HIST_IGNORE_SPACE   # does not record an event starting with a space
SAVEHIST=2048              # stores the maximum number of events to save in the history file
HISTSIZE=2048              # stores the maximum number of events to save in the internal history

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Guide/zshguide04.html
# http://www.geekmind.net/2011/01/shortcuts-to-improve-your-bash-zsh.html
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
# ctrl + enter = accept-and-hold
bindkey "^[[13;5u" accept-and-hold
# in vi mode use j/k for history-substring search
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history

# ^U vi-kill-line
# ^W vi-backward-kill-word
# ^H vi-backward-delete-char
# ^I fzf-completion
# ^T fzf-file-widget
# ^R fzf-history-widget
# ^[c fzf-cd-widget = alt+c
# ^Q push-line-or-edit

# history-incremental is from editor module
# in vi mode / = history-incremental-search-forward
# in vi mode ? = history-incremental-search-backward

# bindkey '^S' insert-last-word
# bindkey -M vicmd "u" undo
# bindkey -M vicmd "ga" what-cursor-position

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
function colours() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@"
}

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
