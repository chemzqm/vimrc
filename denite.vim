" Install ripgrep with `brew install ripgrep`
nnoremap <silent> <space>b  :<C-u>Denite -mode=normal gitbranch<cr>
nnoremap <silent> \r  :<C-u>CocList -N mru -A<cr>
nnoremap <silent> <space>h  :<C-u>CocList helptags<cr>
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>
nnoremap <silent> <space>t  :<C-u>CocList --normal buffers<cr>
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <space>u  :<C-u>CocList snippets<cr>
nnoremap <silent> <space>w  :exe 'CocList -A -I --normal --input='.expand('<cword>').' words'<CR>
nnoremap <silent> <space>l  :<C-u>CocList --normal locationlist<CR>
nnoremap <silent> <space>q  :<C-u>CocList --normal quickfix<CR>
nnoremap <silent> <space>a  :<C-u>CocList --normal diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList -N extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList -N commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList -N outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I -N symbols<cr>
nnoremap <silent> <space>r  :<C-u>CocList -N mru<cr>
nnoremap <silent> <space>f  :<C-u>CocList -N files<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

function! GetDeleteAction(context)
  let name = a:context['name']
  if name ==# 'mru'
    return 'delete'
  elseif name ==# 'buffers'
    return 'delete'
  elseif name ==# 'gitstatus'
    return 'diff'
  endif
  return ''
endfunction
