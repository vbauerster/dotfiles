
def fzf-file -params 0..1 %{
    fzf "edit $1" "find %arg{1} -name .git -prune -o -name .svn -prune -o -regex '.*\(bower_components\|output\|.mozilla\|firefox\|node_modules\|grunt\|cache\|Cache\|config/\(Slack\|chromium\|goole-chrome\)\).*' -prune -o \( -type d -o -type f -o -type l \) -a -not -path %arg{1} -a -not -name '.' -print | sed 's@^\./@@'"
                # "ag -l -f -p ~/.binignore -p ~/.ignore --hidden --one-device . %arg{1}"
                # "rg --ignore-file ~/.binignore -L --hidden --files %arg{1}"
}

def fzf-git -params 0..1 %{
    fzf "edit $1" "git ls-tree --name-only -r HEAD %arg{1}"
}

def fzf-tag -params 0..1 %{
    fzf "tag $1" "readtags -l | cut -f1 | sort -u"
}

def fzf-cd -params 0..1 %{
    fzf "cd $1" "find %arg{1} -type d -path *.git -prune -o -type d -print"
}

def fzf -params 2 %{ %sh{
    tmp=$(mktemp /tmp/kak-fzf.XXXXXX)
    edit=$(mktemp /tmp/kak-edit.XXXXXX)
    echo "echo eval -client $kak_client \"$1\" | kak -p $kak_session" > $edit
    chmod 755 $edit
    (
        # todo: expect ctrl-[vw] to make execute in new windows instead
        once_float
        urxvt -e sh -c "$2 | fzf --height 100% --reverse --color=16 -e -m --bind 'ctrl-c:execute($edit \"{}\")' > $tmp"
        (while read file; do
            $edit $file
        done) < $tmp
        rm $tmp
        rm $edit
    ) > /dev/null 2>&1 < /dev/null &
} }

def bufzf %{ %sh{
    tmp=$(mktemp /tmp/kak-fzf.XXXXXX)
    setbuf=$(mktemp /tmp/kak-setbuf.XXXXXX)
    delbuf=$(mktemp /tmp/kak-delbuf.XXXXXX)
    echo 'echo eval -client $kak_client "buffer        $1" | kak -p $kak_session' > $setbuf
    echo 'echo eval -client $kak_client "delete-buffer $1" | kak -p $kak_session' > $delbuf
    echo 'echo eval -client $kak_client bufzf              | kak -p $kak_session' >> $delbuf
    chmod 755 $setbuf
    chmod 755 $delbuf
    (
        # todo: expect ctrl-[vw] to make execute in new windows instead
        once_float
        urxvt -e sh -c "echo $kak_buflist | tr ':' '\n' | sort |
            fzf --height 100% --reverse --color=16 -0 -1 -e '--preview=$setbuf {}' --preview-window=up:0 --expect ctrl-d > $tmp"
        if [ -s $tmp ]; then
            ( read action
              read buf
              if [ "$action" == "ctrl-d" ]; then
                  $setbuf $kak_bufname
                  $delbuf $buf
              else
                  $setbuf $buf
              fi) < $tmp
        else
            $setbuf $kak_bufname
        fi
        rm $tmp
        rm $setbuf
        rm $delbuf
    ) > /dev/null 2>&1 < /dev/null &
} }
