define-command -override -hidden \
-docstring "smart-select: select WORD if current selection is only one character" \
smart-select -params 1 %{ evaluate-commands %sh{
    if [ "$1" = "WORD" ]; then
        keys="<a-w>"
    elif [ "$1" = "word" ]; then
        keys="w"
    else
        printf "%s\n" "fail %{wrong word type '$1'}"
    fi
    if [ $(expr $(printf "%s\n" $kak_selection | wc -m) - 1) -eq 1 ]; then
        printf "%s\n" "execute-keys -save-regs '' <a-i>${keys}"
    fi
}}

define-command -override -docstring \
"search-file <filename>: search for file recusively under path option: %opt{path}" \
search-file -params 1 %{ evaluate-commands %sh{
    file=$(printf "%s\n" $1 | sed -E "s:^~/:$HOME/:")
    eval "set -- $kak_buflist"
    while [ $# -gt 0 ]; do            # Check if buffer with this
        if [ "$file" = "$1" ]; then   # file already exists. Basically
            printf "%s\n" "buffer $1" # emulating what edit command does
            exit
        fi
        shift
    done
    if [ -e "$file" ]; then                     # Test if file exists under
        printf "%s\n" "edit -existing %{$file}" # servers' working directory
        exit                                    # this is last resort until
    fi                                          # we start recursive searchimg

    # if everthing  above fails - search for file under path
    eval "set -- $kak_opt_path"
    while [ $# -gt 0 ]; do
        case $1 in                        # Since we want to check fewer places
            ./) path=${kak_buffile%/*} ;; # I've swapped ./ and %/ because
            %/) path=$PWD ;;              # %/ usually has smaller scope. So
            *)  path=$1 ;;                # this trick is a speedi-up hack.
        esac
        if [ -z "${file##*/*}" ]; then # test if filename contains path
            if [ -e "$path/$file" ]; then
                printf "%s\n" "edit -existing %{$path/$file}"
                exit
            fi
        else # build list of candidates or automatically select if only one found
            IFS='
'
            for candidate in $(find -L $path -mount -type f -name "$file"); do
                if [ -n "$candidate" ]; then
                    candidates="$candidates %{$candidate} %{evaluate-commands %{edit -existing %{$candidate}}}"
                fi
            done
            if [ -n "$candidates" ]; then
                printf "%s\n" "menu -auto-single $candidates"
                exit
            fi
        fi
        shift
    done
    printf "%s\n" "echo -markup %{{Error}unable to find file '$file'}"
}}

define-command -override -docstring \
"select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{ execute-keys -save-regs '' %sh{
    if [ $(expr $(printf "%s\n" $kak_selection | wc -m) - 1) -eq 1 ]; then
        printf "%s\n" "<a-i>w*"
    else
        printf "%s\n" "*<s-n>"
    fi
}}

define-command -override -docstring "symbol [<symbol>]: jump to symbol definition in current file.
If no symbol given, current selection is used as a symbol name" \
-shell-script-candidates %{
    tags="${TMPDIR:-/tmp}/tags-tmp"
    ctags -f "$tags" "$kak_buffile"
    cut -f 1 "$tags" | grep -v '^!' | awk '!x[$0]++'
} symbol -params ..1 %{ evaluate-commands %sh{
    export tagname="${1:-$kak_selection}"
    tags="${TMPDIR:-/tmp}/tags-tmp"
    if [ ! -s "$tags" ]; then
        ctags -f "$tags" "$kak_buffile"
    fi
    readtags -t "$tags" "$tagname" | awk -F '\t|\n' '
        /[^\t]+\t[^\t]+\t\/\^.*\$?\// {
            opener = "{"; closer = "}"
            line = $0; sub(".*\t/\\^", "", line); sub("\\$?/$", "", line);
            menu_info = line; gsub("!", "!!", menu_info); gsub(/^[\t+ ]+/, "", menu_info); gsub(opener, "\\"opener, menu_info); gsub(/\t/, " ", menu_info);
            keys = line; gsub(/</, "<lt>", keys); gsub(/\t/, "<c-v><c-i>", keys); gsub("!", "!!", keys); gsub("&", "&&", keys); gsub("?", "??", keys); gsub("\\|", "||", keys); gsub("\\\\/", "/", keys);
            menu_item = $2; gsub("!", "!!", menu_item);
            edit_path = $2; gsub("&", "&&", edit_path); gsub("?", "??", edit_path); gsub("\\|", "||", edit_path);
            select = $1; gsub(/</, "<lt>", select); gsub(/\t/, "<c-v><c-i>", select); gsub("!", "!!", select); gsub("&", "&&", select); gsub("?", "??", select); gsub("\\|", "||", select);
            out = out "%!" menu_item ": {MenuInfo}" menu_info "! %!evaluate-commands %? try %& edit -existing %|" edit_path "|; execute-keys %|/\\Q" keys "<ret>vc| & catch %& echo -markup %|{Error}unable to find tag| &; try %& execute-keys %|s\\Q" select "<ret>| & ? !"
        }
        /[^\t]+\t[^\t]+\t[0-9]+/ {
            opener = "{"; closer = "}"
            menu_item = $2; gsub("!", "!!", menu_item);
            select = $1; gsub(/</, "<lt>", select); gsub(/\t/, "<c-v><c-i>", select); gsub("!", "!!", select); gsub("&", "&&", select); gsub("?", "??", select); gsub("\\|", "||", select);
            menu_info = $3; gsub("!", "!!", menu_info); gsub(opener, "\\"opener, menu_info);
            edit_path = $2; gsub("!", "!!", edit_path); gsub("?", "??", edit_path); gsub("&", "&&", edit_path); gsub("\\|", "||", edit_path);
            line_number = $3;
            out = out "%!" menu_item ": {MenuInfo}" menu_info "! %!evaluate-commands %? try %& edit -existing %|" edit_path "|; execute-keys %|" line_number "gx| & catch %& echo -markup %|{Error}unable to find tag| &; try %& execute-keys %|s\\Q" select "<ret>| & ? !"
        }
        END { print ( length(out) == 0 ? "echo -markup %{{Error}no such tag " ENVIRON["tagname"] "}" : "menu -markup -auto-single " out ) }'
}}

# Tab completion.
define-command tab-completion-enable %{
  hook -group tab-completion window InsertCompletionShow .* %{
    try %{
      # exec -draft 'h<a-K>\s<ret>'
      execute-keys -draft 'h<a-K>\h<ret>'
      map window insert <tab> <c-n>
      map window insert <s-tab> <c-p>
    }
  }
  hook -group tab-completion window InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
  }
}
define-command tab-completion-disable %{ remove-hooks window tab-completion }

# search-highlighting.kak, simplified
define-command search-highlighting-enable %{
  hook window -group search-highlighting NormalKey [/?*nN]|<a-[/?*nN]> %{ try %{
    addhl window/SearchHighlighting dynregex '%reg{/}' 0:Search
  }}
  hook window -group search-highlighting NormalKey <esc> %{ rmhl window/SearchHighlighting }
}
define-command search-highlighting-disable %{
  rmhl window/SearchHighlighting
  rmhooks window search-highlighting
}

# Basic autoindent.
define-command -hidden basic-autoindent-on-newline %{
  eval -draft -itersel %{
    try %{ exec -draft ';K<a-&>' }                      # copy indentation from previous line
    try %{ exec -draft ';k<a-x><a-k>^\h+$<ret>H<a-d>' } # remove whitespace from autoindent on previous line
  }
}
define-command basic-autoindent-enable %{
  hook -group basic-autoindent window InsertChar '\n' basic-autoindent-on-newline
  hook -group basic-autoindent window WinSetOption 'filetype=.*' basic-autoindent-disable
}
define-command basic-autoindent-disable %{ rmhooks window basic-autoindent }

# def selection-length %{echo %sh{echo ${#kak_selection} }}
define-command selection-length %{
    eval %sh{ echo "echo ${#kak_selection}" }
}

define-command trim-trailing-whitespace -docstring "trim trailing whitespaces" %{
  try %{
    eval -draft %{
      exec '%s\h+$<ret><a-d>'
      eval -client %val{client} echo -markup -- \
        %sh{ echo "{Information}trimmed trailing whitespaces on $(echo "$kak_selections_desc" | wc -w) lines" }
    }
  } catch %{
    echo -markup "{Information}no trailing whitespaces"
  }
}

define-command enlarge-selection %{
  exec '<a-:>L<a-;>H<a-:>'
}
define-command shrink-selection %{
  exec '<a-:>H<a-;>L<a-:>'
}
define-command slice-by-camel %{
  exec s[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
}

# https://github.com/mawww/kakoune/wiki/Selections#how-to-convert-between-common-case-conventions
# foo_bar → fooBar
# foo-bar → fooBar
# foo bar → fooBar
define-command camelcase %{
  exec '`s[-_<space>]<ret>d~<a-i>w'
}

# fooBar → foo_bar
# foo-bar → foo_bar
# foo bar → foo_bar
define-command snakecase %{
  exec '<a-:><a-;>s-|[a-z][A-Z]<ret>\;a<space><esc>s[-\s]+<ret>c_<esc><a-i>w`'
}

# fooBar → foo-bar
# foo_bar → foo-bar
# foo bar → foo-bar
define-command kebabcase %{
  exec '<a-:><a-;>s_|[a-z][A-Z]<ret>\;a<space><esc>s[_\s]+<ret>c-<esc><a-i>w`'
}

# https://github.com/mawww/kakoune/wiki/Selections#how-to-make-x-select-lines-downward-and-x-select-lines-upward
define-command -params 1 extend-line-down %{
  exec "<a-:>%arg{1}X"
}
define-command -params 1 extend-line-up %{
  exec "<a-:><a-;>%arg{1}K<a-;>"
  try %{
    exec -draft ';<a-K>\n<ret>'
    exec X
  }
  exec '<a-;><a-X>'
}

# https://github.com/mawww/kakoune/wiki/Normal-mode-commands#suggestions
define-command -hidden -params 1 zero %{
   eval %sh{
        if [ $kak_count = 0 ]; then
            echo "$1"
        else
            echo "exec ${kak_count}0"
        fi
    }
}

# https://github.com/alyssais/dotfiles/blob/master/.config/kak/kakrc#L30-L38
define-command -docstring "import from the system clipboard" clipboard-import %{
  set-register dquote %sh{pbpaste}
  echo -markup "{Information}imported system clipboard to "" register"
}
define-command -docstring "export to the system clipboard" clipboard-export %{
  nop %sh{ printf "%s" "$kak_main_reg_dquote" | pbcopy }
  echo -markup "{Information}exported "" register to system clipboard"
}

# Sort of a replacement for gq.
# def format-par %{ exec '|par -w%opt{autowrap_column}<a-!><ret>' }
# def format-text %{ exec '|fmt -w 80<ret>: echo -markup {green}[sel] | fmt -w 80<ret>' }
define-command format-text %{ exec '|fmt %opt{autowrap_column}<a-!><ret>' }
define-command format-comment %{ exec '<a-s>ght/F<space>dx<a-_>|fmt<a-!><ret><a-s>Px<a-_>' }

# https://github.com/shachaf/kak/blob/c2b4a7423f742858f713f7cfe2511b4f9414c37e/kakrc#L218
# define-command select-word-better %{
#   # Note: \w doesn't use extra_word_chars.
#   eval -itersel %{
#     try %{ exec '<a-i>w' } catch %{ exec '<a-l>s\w<ret>) <a-i>w' } catch %{}
#   }
#   exec '<a-k>\w<ret>'
# }
# define-command select-WORD-better %{
#   eval -itersel %{
#     try %{ exec '<a-i><a-w>' } catch %{ exec '<a-l>s\S<ret>) <a-i><a-w>' } catch %{}
#   }
#   exec '<a-k>\S<ret>'
# }

# https://github.com/shachaf/kak/blob/c2b4a7423f742858f713f7cfe2511b4f9414c37e/kakrc#L241
define-command switch-to-modified-buffer %{
  eval -save-regs a %{
    reg a ''
    try %{
      eval -buffer * %{
        eval %sh{[ "$kak_modified" = true ] && echo "reg a %{$kak_bufname}; fail"}
      }
    }
    eval %sh{[ -z "$kak_main_reg_a" ] && echo "fail 'No modified buffers!'"}
    buffer %reg{a}
  }
}

# Git extras.
# https://github.com/shachaf/kak/blob/c2b4a7423f742858f713f7cfe2511b4f9414c37e/kakrc#L381
define-command git-show-blamed-commit %{
  git show %sh{git blame -L "$kak_cursor_line,$kak_cursor_line" "$kak_buffile" | awk '{print $1}'}
}
define-command git-log-lines %{
  git log -L %sh{
    anchor="${kak_selection_desc%,*}"
    anchor_line="${anchor%.*}"
    echo "$anchor_line,$kak_cursor_line:$kak_buffile"
  }
}
define-command git-toggle-blame %{
  try %{
    addhl window/git-blame group
    rmhl window/git-blame
    git blame
  } catch %{
    git hide-blame
  }
}
define-command git-hide-diff %{ rmhl window/git-diff }

# https://github.com/shachaf/kak/blob/c2b4a7423f742858f713f7cfe2511b4f9414c37e/kakrc#L355
define-command -docstring %{switch to the other client's buffer} \
  other-client-buffer \
  %{ eval %sh{
  if [ "$(echo "$kak_client_list" | wc -w)" -ne 2 ]; then
    echo "fail 'only works with two clients'"
    exit
  fi
  set -- $kak_client_list
  other_client="$1"
  [ "$other_client" = "$kak_client" ] && other_client="$2"
  echo "eval -client '$other_client' 'eval -client ''$kak_client'' \"buffer ''%val{bufname}''\"'"
}}

# https://github.com/shachaf/kak/blob/c2b4a7423f742858f713f7cfe2511b4f9414c37e/kakrc#L347
define-command man-selection-with-count %{
  man %sh{
    page="$kak_selection"
    [ "$kak_count" != 0 ] && page="${page}(${kak_count})"
    echo "$page"
  }
}

# https://github.com/mawww/kakoune/wiki/Selections#how-to-select-the-smallest-single-selection-containing-every-selection
# def selection-hull %{
#   eval -save-regs 'abc' %{
#     exec '"aZ' '<space>"bZ' '"az<a-space>"cZ'
#     eval -itersel %{ exec '"b<a-Z>u' }
#     exec '"bz'
#   }
# }

# https://github.com/shachaf/kak/blob/c2b4a7423f742858f713f7cfe2511b4f9414c37e/kakrc#L302
define-command selection-hull \
  -docstring 'The smallest single selection containing every selection.' \
  %{
  eval -save-regs 'ab' %{
    exec '"aZ' '<space>"bZ'
    try %{ exec '"az<a-space>' }
    exec -itersel '"b<a-Z>u'
    exec '"bz'
    echo
  }
}
alias global hull selection-hull

# define-command -hidden smart-star -params 1 %{
#     try %{
#         exec -draft <a-space>
#         eval -no-hooks -draft -save-regs '"' %{
#             exec -save-regs '' "%arg{1}""""*"
#             edit -scratch *smart-star-temp*
#             exec '<a-P>)<a-space>i|<esc>'
#         }
#         try %{ exec -buffer *smart-star-temp* -save-regs '' "%%H""%val{register}/<c-r>.<ret>" }
#         db *smart-star-temp*
#     } catch %{
#         exec -save-regs '' """%val{register}%arg{1}"
#     }
# }
