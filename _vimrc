set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set expandtab  "not use TAB, use space
set softtabstop=4 " unify 
set shiftwidth=4 " unify 
set smarttab " use tabs at the start of a line, spaces elsewhere 
" color koehler
colors puff
set guifont=Courier_New:h11

" It's used in the 'People's Republic of China'
"set fileencodings=utf-8,prc
"set fileencoding=prc
"set encoding=prc 


" ��ݴ򿪱༭vimrc�ļ��ļ��̰�
map <silent> <leader>ee :e $VIM/_vimrc<cr>
autocmd! bufwritepost *.vimrc source $VIM/_vimrc


" �жϲ���ϵͳ
if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1
else
    let g:isWin = 0
endif

" �ж����ն˻���gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


set history=100
set helplang=cn
set backupdir=$VIM/data/backup " where to put backup file 
autocmd FileType c set omnifunc=ccomplete#Complete



" ������ڵĿ�ȣ���TagList,NERD_tree�ȣ��Լ�����
let s:PlugWinSize = 30


map <F2> :set go=<CR>
map <F4> :call Search_Word()<CR>

map <F5> a<C-R>=strftime("%H:%M %Y-%m-%d")<ESC><ESC>
map! <F5> <C-R>=strftime("%H:%M %Y-%m-%d")<RETURN>





" ״̬��
set laststatus=2      " ������ʾ״̬��
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" ��ȡ��ǰ·������$HOMEת��Ϊ~
function! CurDir()
" let curdir = substitute(getcwd(), $HOME, "~", "g")
    let curdir = getcwd()
    return curdir
endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\ 
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]


" �������
" �Զ�������ź�����
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i



" ��д
iab idate <c-r>=strftime("%Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>
iab imail Zelor <zelor.chang@gmail.com>
iab iname Zelor Chang
 


"  plugins Tlist
map <F3> :Tlist<CR> 
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 0
let Tlist_Exit_OnlyWindow = 1 
"let Tlist_Use_Right_Window = 1     " ��Tlist�����ڴ����ұ�
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




set diffexpr=MyDiff()
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

