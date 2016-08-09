# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

# A helper function to join multi-line output from fzf
join-lines() {
local item
while read item; do
  echo -n "${(q)item} "
done
}

fzf-gt-widget() LBUFFER+=$(gt | join-lines)
zle -N fzf-gt-widget
