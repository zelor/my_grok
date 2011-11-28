" 判断操作系统
if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1
else
    let g:isWin = 0
endif


" 判断是终端还是gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


set nocompatible
source $VIMRUNTIME/vimrc_example.vim

if (g:isWin)
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif

set expandtab  "not use TAB, use space
set softtabstop=4 " unify 
set shiftwidth=4 " unify 
set smarttab " use tabs at the start of a line, spaces elsewhere 
" color koehler
if (g:isGUI)
  colors puff
endif

set guifont=Courier_New:h11

" It's used in the 'People's Republic of China'
"set fileencodings=utf-8,prc
"set fileencoding=prc
"set encoding=prc 


" 快捷打开编辑vimrc文件的键盘绑定
if (g:isWin)
  map <silent> <leader>ee :e $VIM/_vimrc<cr>
  autocmd! bufwritepost *.vimrc source ~/_vimrc
else
  map <silent> <leader>ee :e ~/.vimrc<cr>
  autocmd! bufwritepost *.vimrc source ~/.vimrc
endif



set history=100

if (g:isWin)
  set helplang=cn
  set backupdir=$VIM/data/backup " where to put backup file 
else
  set backupdir=~/.backup " where to put backup file 
endif

"TODO：此处增加对vim版本号的判断，若大于7则有效
autocmd FileType c set omnifunc=ccomplete#Complete

set incsearch
set ignorecase
set smartcase


"在gvim中高亮当前行
if (g:isGUI)
    set cursorline
    hi cursorline guibg=#87CEEB
    hi CursorColumn guibg=#87CEEB
    
    "该高亮行配色非常适合于desert配色
    "hi cursorline guibg=#333333
    "hi CursorColumn guibg=#333333

    "set guifont=Consolas\ 14
    "set guifontwide=Consolas\ 14
endif


" 插件窗口的宽度，如TagList,NERD_tree等，自己设置
let s:PlugWinSize = 30


map <F2> :set go=<CR>
map <F4> :call Search_Word()<CR>

map <F5> a<C-R>=strftime("%H:%M %Y-%m-%d")<ESC><ESC>
map! <F5> <C-R>=strftime("%H:%M %Y-%m-%d")<RETURN>





" 状态栏
set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" 获取当前路径，将$HOME转化为~
function! CurDir()
" let curdir = substitute(getcwd(), $HOME, "~", "g")
    let curdir = getcwd()
    return curdir
endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\ 
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]


" 快捷输入
" 自动完成括号和引号
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i



" 缩写
iab idate <c-r>=strftime("%Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>
iab imail Zelor <zelor.chang@gmail.com>
iab iname Zelor Chang
 


"  plugins Tlist
map <F3> :Tlist<CR> 
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 0
let Tlist_Exit_OnlyWindow = 1 
"let Tlist_Use_Right_Window = 1     " 将Tlist设置在窗口右边
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_WinWidth = s:PlugWinSize
let Tlist_Auto_Open = 0
let Tlist_Display_Prototype = 0
"let Tlist_Close_On_Select = 1



" Doxygen toolkit
let g:DoxygenToolkit_authorName="Zelor Chang"


" C plugins
let g:C_AuthorName="Zelor Chang"
let g:C_AuthorRef    = 'ZL'
let g:C_Email        = 'zelor.chang@gmail.com'
let g:C_Company      = 'PANOCOM'


" clever tab completion
fun! KeywordComplete()
    let left = strpart(getline('.'), col('.') - 2, 1)
    if left =~ "^$"
        return "\<Tab>"
    elseif left =~ ' $'
        return "\<Tab>"
    else
        return "\<C-N>"
endfun
inoremap <silent> <Tab> <C-R>=KeywordComplete()<CR>
 
fun! OmniComplete()
    let left = strpart(getline('.'), col('.') - 2, 1)
    if left =~ "^$"
        return ""
    elseif left =~ ' $'
        return ""
    else
        return "\<C-x>\<C-o>"
endfun
inoremap <silent> <S-Tab> <C-R>=OmniComplete()<CR>




if (g:isWin)
  set diffexpr=MyDiff()
endif

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if &sh =~ '\<cmd'
    silent execute '!""diff" ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . '"'
  else
    silent execute '!diff" ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  endif
endfunction

