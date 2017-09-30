TPM=~/.tmux/plugins/tpm

if [[ ! -e $TPM ]]; then
    mkdir -p $TPM
    git clone "https://github.com/tmux-plugins/tpm" $TPM
fi

for cfile in ~/.tmux/*.conf; do
    if [[ -L $cfile ]]; then
        mv -f $cfile ~/.${cfile##*/}
    fi
done
