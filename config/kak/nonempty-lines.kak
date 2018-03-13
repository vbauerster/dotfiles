# Todo: rewrite without loops

def ensure-empty-line %{
    exec -no-hooks -draft \;<a-x><a-k>^\h*$<ret>
}

def _while-empty -params 1 %{
    try %{
        exec -no-hooks -draft \;Gg<a-k>(\n.*){3}<ret>
        exec -no-hooks -draft \;Ge<a-k>(\n.*){3}<ret>
        ensure-empty-line
        exec -no-hooks %arg{1}
        _while-empty %arg{1}
    }
}

def while-empty -params 1 %{ eval -no-hooks -itersel _while-empty %arg{1} }

def remove-adjacent-empty-line -params 1 %{
    eval -no-hooks -itersel %{
        try %{
            eval -no-hooks -draft %{
                exec -no-hooks %arg{1}
                ensure-empty-line
                exec -no-hooks <a-x>d
            }
        }
    }
}

def remove-all-adjacent-empty-lines %{
    eval -save-regs x -draft -no-hooks %{
        reg x ''
        try %{ exec -draft gh <a-?>[^\n]<ret>"xZ     }
        try %{ exec -draft gl ?    [^\n]<ret>"x<a-Z> }
        exec \"xz<a-s><a-k>^\h*$<ret>d
    }
}
