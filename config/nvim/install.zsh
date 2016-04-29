for rcfile in $PWD/*; do
  f=$(basename $rcfile)
  if [[ -d "$rcfile" || "$f" == $(basename $0) ]]; then
    continue
  fi
  ln -s "$rcfile" "$HOME/.config/nvim/$f"
done
