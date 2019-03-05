## Plugins
plug "andreyorst/plug.kak" noload

plug "occivink/kakoune-vertical-selection" config %{
    map global normal '^' ': select-vertically<ret>'
}

plug "delapouite/kakoune-text-objects"

plug "occivink/kakoune-expand" config %{
    set-option global expand_commands %{
        expand-impl %{ exec <a-a>b }
        expand-impl %{ exec <a-a>B }
        expand-impl %{ exec <a-a>r }
        expand-impl %{ exec <a-i>i }
        expand-impl %{ exec <a-i>u }
        expand-impl %{ exec <a-a>u }
        expand-impl %{ exec '<a-:><a-;>k<a-K>^$<ret><a-i>i' } # previous indent level (upward)
        expand-impl %{ exec '<a-:>j<a-K>^$<ret><a-i>i' }      # previous indent level (downward)
    }
}

plug "delapouite/kakoune-buffers" config %{
    hook global WinDisplay .* info-buffers
    map global user b ': enter-user-mode buffers<ret>' -docstring 'buffers'
    map global user B ': enter-user-mode -lock buffers<ret>' -docstring 'buffers (lock)'
}

plug "delapouite/kakoune-cd" config %{
    map global goto '.' '<esc>: change-directory-current-buffer<ret>' -docstring 'current buffer dir'
    map global goto p '<esc>: cd ..;print-working-directory<ret>' -docstring 'parent dir'
}

plug "andreyorst/smarttab.kak" %{
    set-option global softtabstop 4
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme) expandtab
    hook global WinSetOption filetype=(makefile) noexpandtab
    hook global WinSetOption filetype=(c|cpp|go) smarttab
}

plug "andreyorst/fzf.kak" config %{
    map -docstring 'fzf-mode'  global user 'p' ': fzf-mode<ret>'
    map -docstring 'fzf-ctags' global user 'c' ': enter-user-mode fzf-ctags<ret>'
    set-option global fzf_preview_width '65%'
    unmap global fzf v
    unmap global fzf <a-v>
    map global fzf g ': fzf-vcs<ret>' -docstring 'edit file from vcs repo'
    map global fzf <a-g> ': fzf-vcs-mode<ret>' -docstring 'switch to vcs selection mode'
    evaluate-commands %sh{
        if command -v fd > /dev/null; then
            # echo "set-option global fzf_file_command 'fd . --no-ignore --type f --follow'"
            echo "set-option global fzf_file_command %{fd . --type f --follow --exclude .git --exclude .svn --exclude TAGS}"
        fi
        command -v blsd > /dev/null && echo "set-option global fzf_cd_command '(echo .. && blsd)'"
        command -v bat > /dev/null && echo "set-option global fzf_highlighter bat"
        command -v tree > /dev/null && echo "set-option global fzf_cd_preview true"
        # [ ! -z "$(command -v rg)" ] && echo "set-option global fzf_sk_grep_command %{$kak_opt_grepcmd}"
    }
}

plug "TeddyDD/kakoune-edit-or-dir" config %{
    unalias global e edit
    alias global e edit-or-dir
}

plug "occivink/kakoune-phantom-selection" config %{
    declare-user-mode phantom
    map global phantom <plus>     ': phantom-sel-add-selection<ret>' -docstring 'phantom-sel add'
    map global phantom <minus>    ': phantom-sel-select-all; phantom-sel-clear<ret>' -docstring 'phantom-sel clear all'
    map global phantom <)>        ': phantom-sel-iterate-next<ret>' -docstring 'phantom-sel n'
    map global phantom <(>        ': phantom-sel-iterate-prev<ret>' -docstring 'phantom-sel p'
    map global normal <plus>      ': enter-user-mode phantom<ret>'
    map global normal <a-plus>    ': enter-user-mode -lock phantom<ret>'

    # # replace select-onto with phantom-sel stuff; more useful
    # map global normal f     ': phantom-sel-add-selection<ret>'
    # map global normal F     ': phantom-sel-select-all; phantom-sel-clear<ret>'
    # map global normal <a-f> ': phantom-sel-iterate-next<ret>'
    # map global normal <a-F> ': phantom-sel-iterate-prev<ret>'
    # map global insert <a-f> '<esc>: phantom-sel-iterate-next<ret>i'
    # map global insert <a-F> '<esc>: phantom-sel-iterate-prev<ret>i'
}

plug "alexherbo2/auto-pairs.kak" config %{
    hook global WinSetOption filetype=(c|cpp|go|rust) %{
        auto-pairs-enable
    }
}

plug "occivink/kakoune-snippets" config %{
    set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
    set-option global snippets_auto_expand false
    map -docstring 'snippets-menu' global user 's' ': snippets-menu<ret>'
    # map global insert '<tab>' "z<a-;>: snippets-expand-or-jump 'tab'<ret>"
    map global insert '<ret>' "z<esc>: snippets-expand-or-jump 'ret'<ret>"
    # map global normal '<tab>' ": snippets-select-next-placeholders<ret>"

    # hook global InsertCompletionShow .* %{
    #     try %{
    #         execute-keys -draft 'h<a-K>\h<ret>'
    #         map window insert '<ret>' "z<a-;>: snippets-expand-or-jump 'ret'<ret>"
    #     }
    # }

    # hook global InsertCompletionHide .* %{
    #     unmap window insert '<ret>' "z<a-;>: snippets-expand-or-jump 'ret'<ret>"
    # }

    define-command snippets-expand-or-jump -params 1 %{
        # execute-keys <backspace>
        execute-keys 'hd'
        try %{
            snippets-expand-trigger %{
                set-register / "%opt{snippets_triggers_regex}\z"
                execute-keys 'hGhs<ret>'
            }
        } catch %{
            snippets-select-next-placeholders
        } catch %sh{
            case $1 in
                ret|tab)
                    printf "%s\n" "execute-keys -with-hooks i<$1>" ;;
                *)
                    printf "%s\n" "execute-keys -with-hooks i$1" ;;
            esac
        }
    }
}

plug "andreyorst/kakoune-snippet-collection"

plug "alexherbo2/distraction-free.kak" config %{
    alias global df distraction-free-toggle
}

plug "occivink/kakoune-filetree" config %{
    map global normal <minus> ': change-directory-current-buffer;filetree<ret>' -docstring 'filetree in current buf dir'
    # map global normal <minus> ': filetree<ret>' -docstring 'filetree'
}

plug "ul/kak-tree" config %{
    # set global tree_cmd 'kak-tree -c /Users/vbauer/dotfiles/config/kak/kak-tree.toml'
    hook global WinSetOption filetype=(go) %{
        declare-user-mode syntax-tree-children
        map global syntax-tree-children c ': tree-select-children<ret>' -docstring 'children'
        map global syntax-tree-children t ': tree-select-children type_declaration<ret>' -docstring 'type_declaration'
        map global syntax-tree-children m ': tree-select-children method_declaration<ret>' -docstring 'method_declaration'
        map global syntax-tree-children f ': tree-select-children function_declaration<ret>' -docstring 'function_declaration'
        map global syntax-tree-children l ': tree-select-children func_literal<ret>' -docstring 'func_literal'
        map global syntax-tree-children g ': tree-select-children go_statement<ret>' -docstring 'go_statement'
        map global syntax-tree-children b ': tree-select-children block<ret>' -docstring 'block'
        map global syntax-tree-children i ': tree-select-children if_statement<ret>' -docstring 'if_statement'
        map global syntax-tree-children o ': tree-select-children for_statement<ret>' -docstring 'for_statement'
        map global syntax-tree-children u ': tree-select-children parameter_list<ret>' -docstring 'parameter_list'
        map global syntax-tree-children r ': tree-select-children return_statement<ret>' -docstring 'return_statement'
        map global syntax-tree-children <backspace> ': enter-user-mode syntax-tree<ret>' -docstring 'back...'

        declare-user-mode syntax-tree-parent
        map global syntax-tree-parent p ': tree-select-parent-node<ret>' -docstring 'parent_node'
        map global syntax-tree-parent t ': tree-select-parent-node type_declaration<ret>' -docstring 'type_declaration'
        map global syntax-tree-parent m ': tree-select-parent-node method_declaration<ret>' -docstring 'method_declaration'
        map global syntax-tree-parent f ': tree-select-parent-node function_declaration<ret>' -docstring 'function_declaration'
        map global syntax-tree-parent l ': tree-select-parent-node func_literal<ret>' -docstring 'func_literal'
        map global syntax-tree-parent g ': tree-select-parent-node go_statement<ret>' -docstring 'go_statement'
        map global syntax-tree-parent b ': tree-select-parent-node block<ret>' -docstring 'block'
        map global syntax-tree-parent i ': tree-select-parent-node if_statement<ret>' -docstring 'if_statement'
        map global syntax-tree-parent o ': tree-select-parent-node for_statement<ret>' -docstring 'for_statement'
        map global syntax-tree-parent u ': tree-select-parent-node parameter_list<ret>' -docstring 'parameter_list'
        map global syntax-tree-parent r ': tree-select-parent-node return_statement<ret>' -docstring 'return_statement'
        map global syntax-tree-parent <backspace> ': enter-user-mode syntax-tree<ret>' -docstring 'back...'

        declare-user-mode syntax-tree-next
        map global syntax-tree-next ')' ': tree-select-next-node<ret>' -docstring 'next_node'
        map global syntax-tree-next t   ': tree-select-next-node type_declaration<ret>' -docstring 'type_declaration'
        map global syntax-tree-next m   ': tree-select-next-node method_declaration<ret>' -docstring 'method_declaration'
        map global syntax-tree-next f   ': tree-select-next-node function_declaration<ret>' -docstring 'function_declaration'
        map global syntax-tree-next b   ': tree-select-next-node block<ret>' -docstring 'block'
        map global syntax-tree-next i   ': tree-select-next-node if_statement<ret>' -docstring 'if_statement'
        map global syntax-tree-next o   ': tree-select-next-node for_statement<ret>' -docstring 'for_statement'
        map global syntax-tree-next u   ': tree-select-next-node parameter_list<ret>' -docstring 'parameter_list'
        map global syntax-tree-next r   ': tree-select-next-node return_statement<ret>' -docstring 'return_statement'
        map global syntax-tree-next <backspace> ': enter-user-mode syntax-tree<ret>' -docstring 'back...'

        declare-user-mode syntax-tree-prev
        map global syntax-tree-prev '(' ': tree-select-previous-node<ret>' -docstring 'previous_node'
        map global syntax-tree-prev t ': tree-select-previous-node type_declaration<ret>' -docstring 'type_declaration'
        map global syntax-tree-prev m ': tree-select-previous-node method_declaration<ret>' -docstring 'method_declaration'
        map global syntax-tree-prev f ': tree-select-previous-node function_declaration<ret>' -docstring 'function_declaration'
        map global syntax-tree-prev b ': tree-select-previous-node block<ret>' -docstring 'block'
        map global syntax-tree-prev i ': tree-select-previous-node if_statement<ret>' -docstring 'if_statement'
        map global syntax-tree-prev o ': tree-select-previous-node for_statement<ret>' -docstring 'for_statement'
        map global syntax-tree-prev u ': tree-select-previous-node parameter_list<ret>' -docstring 'parameter_list'
        map global syntax-tree-prev r ': tree-select-previous-node return_statement<ret>' -docstring 'return_statement'
        map global syntax-tree-prev <backspace> ': enter-user-mode syntax-tree<ret>' -docstring 'back...'

        declare-user-mode syntax-tree
        map global syntax-tree '(' ': enter-user-mode syntax-tree-prev<ret>' -docstring 'previous_node'
        map global syntax-tree ')' ': enter-user-mode syntax-tree-next<ret>' -docstring 'next_node'
        map global syntax-tree c ': enter-user-mode syntax-tree-children<ret>' -docstring 'children'
        map global syntax-tree p ': enter-user-mode syntax-tree-parent<ret>' -docstring 'parent_node'
        map global syntax-tree t ': tree-node-sexp<ret>' -docstring 'tree-node-sexp'
        map global user t ': enter-user-mode syntax-tree<ret>' -docstring 'tree select'
    }
}

plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force
} config %{
    set-face global Reference default,rgb:EDF97D
    set-option global lsp_diagnostic_line_error_sign '║'
    set-option global lsp_diagnostic_line_warning_sign '┊'

    define-command ne -docstring 'go to next error/warning from lsp' %{ lsp-find-error --include-warnings }
    define-command pe -docstring 'go to previous error/warning from lsp' %{ lsp-find-error --previous --include-warnings }
    define-command ee -docstring 'go to current error/warning from lsp' %{ lsp-find-error --include-warnings; lsp-find-error --previous --include-warnings }

    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    hook global WinSetOption filetype=(c|cpp|go|rust) %{
        set-option window lsp_auto_highlight_references true
        set-option window lsp_hover_anchor false
        lsp-enable-window
        lsp-auto-signature-help-enable
        # lsp-diagnostic-lines-enable
        # lsp-auto-hover-enable
        # lsp-auto-hover-insert-mode-disable
        # unmap window lsp &
        # map window lsp <*> ': lsp-highlight-references<ret>' -docstring 'lsp-highlight-references'
        map window user a ': enter-user-mode lsp<ret>' -docstring 'lsp mode'
    }

    hook global WinSetOption filetype=(rust) %{
        set-option window lsp_server_configuration rust.clippy_preference="on"
        hook window BufWritePre .* %{
            evaluate-commands %sh{
                test -f rustfmt.toml && printf lsp-formatting-sync
            }
        }
    }

    # hook global WinSetOption filetype=(go) %{
    #     hook window BufWritePre .* %{ lsp-formatting-sync }
    # }

    hook global KakEnd .* lsp-exit
}

source "%val{config}/scripts/colorscheme-browser.kak"
source "%val{config}/scripts/bc.kak"
