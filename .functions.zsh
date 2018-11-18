# GIT heart FZF
# http://junegunn.kr/2016/07/fzf-git
# -------------

fzf-down() {
  fzf --height 50% "$@" --border
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -200'
}

fzf-gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}

fzf-gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

fzf-gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

fzf-gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

fzf-gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

# A helper function to join multi-line output from fzf
# join-lines() {
# local item
# while read item; do
#   echo -n "${(q)item} "
# done
# }

fzf-gt-widget() {
    LBUFFER+=$(fzf-gt)
    zle reset-prompt
}
zle -N fzf-gt-widget

fzf-gh-widget() {
    LBUFFER+=$(fzf-gh)
    zle reset-prompt
}
zle -N fzf-gh-widget

fzf-gf-widget() {
    LBUFFER+=$(fzf-gf)
    zle reset-prompt
}
zle -N fzf-gf-widget

fzf-gb-widget() {
    LBUFFER+=$(fzf-gb)
    zle reset-prompt
}
zle -N fzf-gb-widget

fzf-gr-widget() {
    LBUFFER+=$(fzf-gr)
    zle reset-prompt
}
zle -N fzf-gr-widget

fzf-gs-widget() {
    LBUFFER+=$(fzf-gs)
    zle reset-prompt
}
zle -N fzf-gs-widget

# Figlet font selector => copy to clipboard
fgl() (
  [ $# -eq 0 ] && return
  cd /usr/local/Cellar/figlet/*/share/figlet/fonts
  local font=$(ls *.flf | sort | fzf --no-multi --reverse --preview "figlet -f {} $@") &&
  figlet -f "$font" "$@" | pbcopy
)

# fzf related functions
# ---------------------
# gco - checkout git branch/tag
gco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# ghh - git history browser
ghh() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -200 '" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'nvim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}

# tags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-$COLUMNS | fzf --nth=2 --tiebreak=begin
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

# ee [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
ee() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

if [ -n "$TMUX_PANE" ]; then
  # https://github.com/wellle/tmux-complete.vim
  fzf_tmux_words() {
    tmuxwords.rb --all --scroll 500 --min 5 | fzf-down --multi | paste -sd" " -
  }
  fzf-tmux-words-widget() {
    LBUFFER+=$(fzf_tmux_words)
    zle reset-prompt
  }
  zle -N fzf-tmux-words-widget
  bindkey '^[w' fzf-tmux-words-widget
  # bindkey '^T' undefined-key
  # bindkey '^Tt' fzf-file-widget
  # bindkey '^Tw' fzf-tmux-words-widget

  # tmps - switch pane (@george-b)
  tmps() {
    local panes current_window current_pane target target_window target_pane
    panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    current_pane=$(tmux display-message -p '#I:#P')
    current_window=$(tmux display-message -p '#I')

    target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

    target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
    target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

    if [[ $current_window -eq $target_window ]]; then
      tmux select-pane -t ${target_window}.${target_pane}
    else
      tmux select-pane -t ${target_window}.${target_pane} &&
      tmux select-window -t $target_window
    fi
  }

fi

# Switch tmux-sessions
tmss() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# ch - browse chrome history
ch() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
  ruby -ne '
    cols = ENV["cols"].to_i
    title, url = $_.split(ENV["sep"])
    len = 0
    puts "\x1b[36m" + title.each_char.take_while { |e|
      if len < cols
        len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
      end
    }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
  fzf --ansi --multi --no-hscroll --tiebreak=index |
  sed 's#.*\(https*://\)#\1#' | xargs open
}

# so - my stackoverflow favorites
so() {
    stackoverflow-favorites |
    fzf --ansi --reverse --with-nth ..-2 --tac --tiebreak index |
    awk '{print $NF}' | while read -r line; do
      open "$line"
    done
}

# some custotm functions
# ----------------------

light() {
    export BACKGROUND="light"
}

dark() {
    export BACKGROUND="dark"
}

# print available colors and their numbers
colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
fancy-ctrl-z() {
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

# Song Trimmer
# trimmer <song> <start(sec)> <duration(sec)>
trimmer() {
  ffmpeg -i "$1" -ss "$2" -t "$3" -acodec copy cut_"$1"
}

Fkeys() {
  printf "%-5s%5s\n" "key" "value"; infocmp -1  | awk -F= '/kf/ { key=$1; sub("kf", "", key); printf("%-5d %s\n", key, $2) }'  | sort -n
}

csi() {
  echo -en "\x1b[$*"
}

..cd() {
    cd ..
    cd "$@"
}

# Go up an abritrary number of directories
# Use with 'up' or 'up 5' to go up N directories
up() {
    if [[ "$#" < 1 ]] ; then
        cd ..
    else
        CDSTR=""
        for i in {1..$1} ; do
            CDSTR="../$CDSTR"
        done
        cd $CDSTR
    fi
}

# http://artkoshelev.github.io/posts/sed-for-configs
catconf() {
    cat "$@" | sed '/ *#/d; /^ *$/d'
}

# Tmux tile
# --------------------------------------------------------------------
# tt() {
#   if [ $# -lt 1 ]; then
#     echo 'usage: tt <commands...>'
#     return 1
#   fi
# 
#   local head="$1"
#   local tail='echo -n Press enter to finish.; read'
# 
#   while [ $# -gt 1 ]; do
#     shift
#     tmux split-window "$SHELL -ci \"$1; $tail\""
#     tmux select-layout tiled > /dev/null
#   done
# 
#   tmux set-window-option synchronize-panes on > /dev/null
#   $SHELL -ci "$head; $tail"
# }

# unalias e
# e() {
#   local session="Session.vim"
#   if [ $# -gt 0 ]; then
#     nvim $@
#   elif [ -e $session ]; then
#     nvim -S $session
#   else
#     nvim
#   fi
# }
