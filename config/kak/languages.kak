
hook global WinSetOption filetype=(go) %{
    try %{ set window grepcmd 'rg --column -tgo -g=!vendor' }
    set window matching_pairs '(' ')' '{' '}' '[' ']'
    set window auto_pairs '(' ')' '{' '}' '[' ']' '"' '"' '''' '''' '`' '`'
    set window indentwidth 0
    set window formatcmd 'goimports'
    # alias window jump-to-definition go-jump
    # set buffer lintcmd '(gometalinter | grep -v "::\w")  <'
    # map global goto u '<esc>: go-jump<ret>' -docstring 'go-jump'
    # map global help-and-hovers d ': go-doc-info<ret>' -docstring 'go-doc-info'

    hook buffer BufWritePre .* %{ format }
    # hook window BufWritePost .*\.go %{ format }
}

hook global WinSetOption filetype=(rust) %{
    set window formatcmd 'rustfmt'
}

# hook global WinSetOption filetype=(c|cpp) %{
#     clang-enable-autocomplete; clang-enable-diagnostics
#     alias window lint clang-parse
#     alias window lint-next-error clang-diagnostics-next
#     alias window lint-next-error clang-diagnostics-next
#     map window object ';' '/\*,\*/<ret>'
# }

hook global WinSetOption filetype=(js) %{
    set buffer formatcmd 'js-beautify -a -j -B --good-stuff'
}

hook global WinSetOption filetype=(json) %{
    set buffer formatcmd 'js-beautify'
}

# Markdown
hook global WinSetOption filetype=markdown %{
    remove-highlighter buffer/operators
    remove-highlighter buffer/delimiters
}

# Makefile
hook global BufCreate .*\.mk$ %{
    set-option buffer filetype makefile
}

# Highlight any files whose names start with "zsh" as sh
hook global BufCreate (.*/)?\.?zsh.* %{
    set-option buffer filetype sh
}

# Highlight files ending in .conf as ini
# (Will probably be close enough)
hook global BufCreate .*\.conf %{
    set-option buffer filetype ini
}

