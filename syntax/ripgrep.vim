if exists('b:current_syntax')
  finish
endif

syntax region rgFile start=/./ end=/\n$/ fold contains=rgFileName,rgLineNumber
syntax match rgLineNumber /^\d\+:\@=/ contained
syntax match rgFileName /\%(\%^\|^\n\)\@<=.*/ contained

function! s:hi(group, color, attrs)
  if len(a:attrs)
    let l:joined_attrs = join(a:attrs, ',')
    let l:maybe_attrs = 'cterm=' . l:joined_attrs . ' gui=' . l:joined_attrs
  else
    let l:maybe_attrs = ''
  endif

  execute 'highlight default' a:group l:maybe_attrs
        \ 'ctermfg=' . a:color
        \ 'guifg=' . get(g:, 'terminal_color_' . a:color)
endfunction

call s:hi('rgLineNumber', 10, [])
call s:hi('rgFileName',   13, [])
call s:hi('rgMatch',       9, ['bold'])

highlight default link FoldColumn LineNr

let b:current_syntax = 'rg'
