iabbrev mocah mocha
iabbrev Licence License
iabbrev accross across
iabbrev cosnt const

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('Co', 'Copy')
call SetupCommandAbbrs('B', 'BlogNew')
call SetupCommandAbbrs('T', 'Todo')
call SetupCommandAbbrs('Gd', 'Gdiff')
call SetupCommandAbbrs('Gt', 'GdiffThis')
call SetupCommandAbbrs('Gst', 'Denite gitstatus')
call SetupCommandAbbrs('Gc', 'GcommitCurrent')
call SetupCommandAbbrs('Gp', 'Gpush')
call SetupCommandAbbrs('Gci', 'Gcommit -v')
call SetupCommandAbbrs('Gca', 'Gcommit -a -v')
call SetupCommandAbbrs('Gcaa', 'Gcommit --amend -a -v')
call SetupCommandAbbrs('Gco', 'Gcheckout')
call SetupCommandAbbrs('Grm', 'Gremove')
call SetupCommandAbbrs('Grh', 'Greset HEAD')
call SetupCommandAbbrs('Gmv', 'Gmove')
call SetupCommandAbbrs('L', 'Gitlog')
call SetupCommandAbbrs('U', 'UltiSnipsEdit')
call SetupCommandAbbrs('P', 'Preview')
call SetupCommandAbbrs('N', 'Note')
call SetupCommandAbbrs('Y', 'YarnAdd')
call SetupCommandAbbrs('D', 'Denite')
call SetupCommandAbbrs('R', 'NpmRun')
call SetupCommandAbbrs('M', 'Mouse')
call SetupCommandAbbrs('E', 'EditVimrc')
call SetupCommandAbbrs('S', 'RenameSearch')
call SetupCommandAbbrs('A', 'TodoAdd')
call SetupCommandAbbrs('Ex', 'Execute')
call SetupCommandAbbrs('Ns', 'NoteSearch')
call SetupCommandAbbrs('Done', 'Unite todo:done')

" vim: set sw=2 ts=2 sts=2 et tw=78;
