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

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
#bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

if [ -z "$BACKGROUND" ]; then
    export BACKGROUND="light"
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

function hist() {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Extract archives - use: extract <file>
# Credits to http://dotfiles.org/~pseup/.bashrc
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
