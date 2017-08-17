" Author: naoina <naoina@kuune.org>
" Description: review-compile for Re:VIEW files

function! ale_linters#review#review_compile#Handle(buffer, lines) abort
  let l:pattern = '\v^.+:(\d+): error: (.+)$'
  let l:output = []
  for l:line in a:lines
    let l:match = matchlist(l:line, l:pattern)
    if len(l:match) > 0
      call add(l:output, {
            \ 'lnum': l:match[1] + 0,
            \ 'col': 0,
            \ 'text': l:match[2],
            \ 'type': 'E',
            \ })
    endif
  endfor
  return l:output
endfunction

call ale#linter#Define('review', {
      \ 'name': 'review-compile',
      \ 'executable': 'review-compile',
      \ 'output_stream': 'stderr',
      \ 'command': 'review-compile -c --target=latex %s',
      \ 'callback': 'ale_linters#review#review_compile#Handle',
      \ })
