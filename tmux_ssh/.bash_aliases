# Unix
alias u='ls -1A'         # Lists in one column, hidden files.
alias uh='ls -lh'        # Lists human readable sizes.
alias ur='uu -R'         # Lists human readable sizes, recursively.
alias ua='uh -A'         # Lists human readable sizes, hidden files.
alias um='ua | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias uk='uh -Sr'        # Lists sorted by size, largest last.
alias ut='uh -tr'        # Lists sorted by date, most recent last.
alias uc='ut -c'         # Lists sorted by date, most recent last, shows change time.
alias uu='ut -u'         # Lists sorted by date, most recent last, shows access time.

alias rmm="rm -rf"
alias q='exit'

# File size
alias fs="stat -f \"%z bytes\""

# Pretty print the path
# alias path='echo $PATH | tr -s ":" "\n"'
alias path='echo -e ${PATH//:/\\n}'

# Pretty print the path
alias fpath='echo $FPATH | tr -s ":" "\n"'

# ps aux | grep [h]ttpd
# Eliminates second instance of grep -v (Inverted search)
# http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
# http://www.manpagez.com/info/grep/grep-2.5.4/grep_21.php#SEC21 paragraph 7
alias psg='ps aux | grep $(echo $1 | sed "s/^\(.\)/[\1]/g")'

alias header='curl -I'
alias myip='curl icanhazip.com'
alias t2='tree -Fth -L 2 --du |less' #see tree with size up to 2 levels deep

# tmux
alias tma='tmux attach -d -t'
alias tmn='tmux new -s $(basename $(pwd))'
alias tmu='tmux list-sessions'

# convenience
alias eV='cd ~/dotfiles/config/nvim && nvim init.vim'
alias eT='cd ~/dotfiles/tmux && nvim tmux.conf'
alias eH='cd ~/dotfiles/hammerspoon && nvim init.lua'
alias eS='cd ~/.ssh && nvim config'

# tcpdump
# alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias sniff="sudo ngrep -t '^(GET|POST) ' 'tcp and port 80'"
alias dnsdump="sudo tcpdump -lvi any 'udp port 53'"
# alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias httpdump="sudo tcpdump -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Linux
alias iptll='sudo iptables -L -n -v --line-numbers'
alias iptli='sudo iptables -L INPUT -n -v --line-numbers'
alias iptlo='sudo iptables -L OUTPUT -n -v --line-numbers'
alias iptlf='sudo iptables -L FORWARD -n -v --line-numbers'
