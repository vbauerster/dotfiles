# fzf
define-command -docstring 'invoke fzf to open a file' \
  fzf-file %{
    evaluate-commands %sh{
        if [ -z "$TMUX" ]; then
          echo echo only works inside tmux
        else
          FILE=$(find * -type f | fzf-tmux -d 15)
          if [ -n "$FILE" ]; then
            printf 'eval -client %%{%s} edit %%{%s}\n' "${kak_client}" "${FILE}" | kak -p "${kak_session}"
          fi
        fi
    }
}

define-command -docstring 'Invoke fzf to open a file' -params 0 fzf-edit %{
    evaluate-commands %sh{
        if [ -z "${kak_client_env_TMUX}" ]; then
            printf 'fail "client was not started under tmux"\n'
        else
            file="$(fd --type f --follow |TMUX="${kak_client_env_TMUX}" fzf-tmux -d 15)"
            if [ -n "$file" ]; then
                printf 'edit "%s"\n' "$file"
            fi
        fi
    }
}

# the original version no longer works since kak_buflist is no longer ":" separated.
# this one works if you don't have single quote in file names.

def -override -docstring 'invoke fzf to select a buffer' \
  fzf-buffer %{eval %sh{
      BUFFER=$(printf %s\\n ${kak_buflist} | sed "s/'//g" |fzf-tmux -d 15)
      if [ -n "$BUFFER" ]; then
        echo buffer ${BUFFER}
      fi
} }

map global user b       -docstring 'fzf buffers…'           ': fzf-buffer<ret>'
map global user f       -docstring 'fzf files…'             ': fzf-file<ret>'
map global user e       -docstring 'fzf edit…'              ': fzf-edit<ret>'
