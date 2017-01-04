PLUGGED=~/.config/nvim/plugged
PLUG=~/.config/nvim/autoload/plug.vim

[[ ! -e $PLUGGED ]] && mkdir -p $PLUGGED

[[ ! -e $PLUG ]] && curl -fLo $PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
