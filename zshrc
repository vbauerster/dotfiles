# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export BACKGROUND="light"

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Guide/zshguide04.html
# http://www.geekmind.net/2011/01/shortcuts-to-improve-your-bash-zsh.html
export DOTFILES=$HOME/dotfiles

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# fzf (https://github.com/junegunn/fzf)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --nocolor --hidden --ignore .git -g ""'
# export FZF_DEFAULT_COMMAND="rg -uu -g '!vendor' -g '!.git' --files"
# export FZF_DEFAULT_COMMAND='pt --nocolor --hidden --home-ptignore -U -g ""'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

if [ -x ~/.config/nvim/plugged/fzf.vim/bin/preview.rb ]; then
	export FZF_CTRL_T_OPTS="--preview '~/.config/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

# https://github.com/junegunn/blsd
command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd $dir'
# brew install tree
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Source functions
[[ -f "$DOTFILES/.functions.zsh" ]] && source "$DOTFILES/.functions.zsh"

# Golang
export GOPATH=$HOME/gocode
if [[ ! "$PATH" == *$GOPATH/bin* ]]; then
  export PATH=$GOPATH/bin:$PATH
fi

export GEMPATH=$HOME/.gem/ruby/2.0.0
if [[ ! "$PATH" == *$GEMPATH/bin* ]]; then
  export PATH=$GEMPATH/bin:$PATH
fi

# check for user bin directory and add to path
if [[ ! "$PATH" == *$HOME/bin* && -d $HOME/bin ]]; then
    export PATH=$HOME/bin:$PATH
fi

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
# shift + tab
bindkey '^[[Z' autosuggest-accept

# following just for reference
# ^Q push-line-or-edit

# history-incremental is from editor module
# in vi mode / = history-incremental-search-forward
# in vi mode ? = history-incremental-search-backward

# To view all vicmd bindings: bindkey -M vicmd
bindkey -M vicmd '^U' vi-kill-line

# fzf bindings
# to view all: bindkey-all | rg -i fzf
# http://junegunn.kr/2016/07/fzf-git/
# first unbind '^G', which is bound to list-expand by default
bindkey '^G' undefined-key
# for tags
bindkey '^Gt' fzf-gt-widget
# for commit hashes
bindkey '^Gh' fzf-gh-widget
# for files
bindkey '^Gf' fzf-gf-widget
# for branches
bindkey '^Gb' fzf-gb-widget
# for remotes
bindkey '^Gr' fzf-gr-widget

# https://github.com/kurkale6ka/zsh/blob/master/.zshrc
### ^x0 IPs
# bindkey -s '^x0' '127.0.0.1'
bindkey -s '^x*' '127.0.0.1'
# bindkey -s '^x1' '10.0.0.'
bindkey -s '^x(' '10.0.0.'
# bindkey -s '^x7' '172.16.0.'
bindkey -s '^x[' '172.16.0.'
# bindkey -s '^x9' '192.168.0.'
bindkey -s '^x=' '192.168.0.'

### ^x_ /dev/null
bindkey -s '^x_' '/dev/null'

# Source aliases
[[ -f ~/.aliases ]] && source ~/.aliases
