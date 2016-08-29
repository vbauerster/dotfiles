# GIT heart FZF
# http://junegunn.kr/2016/07/fzf-git
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

fzf-gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

fzf-gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-tmux -m --ansi --nth 2..,.. \
    --preview 'NAME="$(cut -c4- <<< {})" &&
               (git diff --color=always "$NAME" | sed 1,4d; cat "$NAME") | head -'$LINES |
  cut -c4-
}

fzf-gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

fzf-gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 " " $2}' | uniq |
  fzf-tmux --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(cut -d" " -f1 <<< {}) | head -'$LINES |
  cut -d' ' -f1
}

# A helper function to join multi-line output from fzf
join-lines() {
local item
while read item; do
  echo -n "${(q)item} "
done
}

fzf-gt-widget() LBUFFER+=$(fzf-gt | join-lines)
zle -N fzf-gt-widget

fzf-gh-widget() LBUFFER+=$(fzf-gh | join-lines)
zle -N fzf-gh-widget

fzf-gf-widget() LBUFFER+=$(fzf-gf | join-lines)
zle -N fzf-gf-widget

fzf-gb-widget() LBUFFER+=$(fzf-gb | join-lines)
zle -N fzf-gb-widget

fzf-gr-widget() LBUFFER+=$(fzf-gr | join-lines)
zle -N fzf-gr-widget

# fzf related functions
# ---------------------
# zgco - checkout git branch/tag
zgco() {
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

# zghh - git history
zghh() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -$LINES '" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'nvim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}

# zfe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
zfe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# zee [EXACT PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
zee() {
  local file
  file=$(fzf-tmux -e --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Switch tmux-sessions
ts() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf-tmux --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# c - browse chrome history
c() {
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

# some custotm functions
# ----------------------
# export BACKGROUND env var
if [ -z "$BACKGROUND" ]; then
    export BACKGROUND="dark"
fi

# set the background color to light
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
