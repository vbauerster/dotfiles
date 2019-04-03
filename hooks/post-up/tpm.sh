TPM=~/.tmux/plugins/tpm

if [ ! -e $TPM ]; then
    mkdir -p $TPM
    git clone "https://github.com/tmux-plugins/tpm" $TPM
fi

tmux_cfg=~/.tmux/tmux.conf
[ -L $tmux_cfg ] && mv -f $tmux_cfg ~/.${tmux_cfg##*/}
