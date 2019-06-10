" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
" common file autocmd {{
augroup common
  autocmd!
  autocmd BufEnter * call EmptyBuffer()
  "autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd BufWinEnter * call s:OnBufEnter()
  autocmd ColorScheme * call s:Highlight()
  autocmd FileType * call s:OnFileType(expand('<amatch>'))
  autocmd DirChanged,VimEnter * let &titlestring = pathshorten(substitute(getcwd(), $HOME, '~', ''))
  autocmd BufNewFile,BufReadPost *.ejs setf html
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufEnter,FocusGained * checktime
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945

  autocmd CursorHold * silent! call CocActionAsync('highlight')
  autocmd User CocQuickfixChange :CocList --normal quickfix
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  "autocmd FileType txt call PlainText()
  "autocmd CursorMoved * if &previewwindow != 1 | pclose | endif
  "autocmd User CocQuickfixChange :call fzf_quickfix#run()
  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType typescript setl formatexpr=CocAction('formatSelected')
  autocmd FileType typescript let b:coc_pairs_disabled = ['<']
augroup end

function! EmptyBuffer()
  if @% ==# ""
    setfiletype txt
  endif
endfunction

function! s:Highlight() abort
  if !has('gui_running') | hi normal guibg=NONE | endif
  call matchadd('ColorColumn', '\%81v', 100)
  hi ColorColumn ctermbg=magenta ctermfg=0 guibg=#333333
  hi HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A
  highlight link CocErrorSign   GruvboxRedSign
  highlight link CocWarningSign GruvboxYellowSign
  highlight link CocInfoSign    GruvboxYellowSign
  highlight link CocHintSign    GruvboxBlueSign
  highlight link CocFloating    SignColumn
  highlight link MsgSeparator MoreMsg
endfunction

function! s:OnFileType(filetype)
  if index(['xml', 'wxml', 'html', 'wxss', 'css', 'scss', 'less'], a:filetype) >=0
    let b:coc_additional_keywords = ['-']
  endif
endfunction

function! s:OnBufEnter()
  let name = bufname(+expand('<abuf>'))
  " quickly leave those temporary buffers
  if &previewwindow || name =~# '^term://' || &buftype ==# 'nofile' || &buftype ==# 'help'
    if !mapcheck('q', 'n')
      nnoremap <silent><buffer> q :<C-U>bd!<CR>
    endif
  elseif name =~# '/tmp/'
    setl bufhidden=delete
  endif
  unlet name
endfunction
" }}
