" load some Lua specific custom stuff
lua require("init")

" main
set encoding=utf-8
set shell=\"C:\Program\ Files\PowerShell\7\pwsh.exe\"
set fillchars+=vert:\ 
set autochdir

" hi
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi CursorLine guibg=#3c4841 ctermbg=NONE
hi CursorLineNr guibg=NONE guifg=#a7c080
hi normalNC guibg=NONE ctermbg=NONE

" map
nnoremap SS :mkse!<space> ~\ssnv\
nnoremap SR :source<space> ~\ssnv\

"""" s
nnoremap <s-tab> :b<space>

"""" f
nnoremap <F2> :e<space>~\
