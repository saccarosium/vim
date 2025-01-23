" FUNCTIONS IN THIS FILES ARE MENT TO BE USE BY NETRW.VIM AND NETRW.VIM ONLY.
" THIS FUNCTIONS DON'T COMMIT TO ANY BACKWARDS COMPATABILITY. SO CHANGES AND
" BREAKAGES IF USED OUTSIDE OF NETRW.VIM ARE EXPECTED.

let s:deprecation_msgs = []
function! netrw#own#Deprecate(name, alternative, version)
    " If running on neovim use vim.deprecate
    if has('nvim')
        call luaeval('vim.deprecate(unpack(_A)) and nil', [a:name, a:alternative, a:version, "netrw", v:false])
        return
    endif

    " If we did notify for something only do it once
    if s:deprecation_msgs->index(a:name) >= 0
        return
    endif

    echohl WarningMsg
    echomsg printf('%s is deprecated, use %s instead.', a:name, a:alternative)
    echomsg printf('Feature will be removed in netrw %s', a:version)
    echohl None

    call add(s:deprecation_msgs, a:name)
endfunction

let s:slash = &shellslash ? '/' : '\'
function! netrw#own#JoinPath(...)
    let path = ""

    for arg in a:000
        if empty(path)
            let path = arg
        else
            let path .= s:slash . arg
        endif
    endfor

    return path
endfunction

" vim:ts=8 sts=4 sw=4 et fdm=marker
