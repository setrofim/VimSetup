set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

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
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"------------------------------------------------------------------------------

" Sergei's settings

"------------------------------------------------------------------------------

map <F2> :echo 'Current time is ' . strftime('%c')<CR>
nmap \l :FufLine<CR>
nmap \f :FufFile<CR>
nmap \m :FufMruFile<CR>

syntax on
filetype on
filetype plugin on
filetype indent on

" from http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=100
runtime macros/matchit.vim
set wildmenu
set wildmode=list:longest
set title
set backspace=indent,eol,start
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>
set shortmess=atI

set autowrite

au BufNewFile,BufRead *.flm,*.mk set filetype=make
au BufNewFile,BufRead *.r set filetype=r
au BufNewFile,BufRead *.pyf set filetype=python
au BufNewFile,BufRead *.oby,*.iby,bld*.inf,*.mmp,*.hrh set filetype=cpp
au BufNewFile,BufRead *.py,*.pyw,*.pyf set expandtab

" pydiction
let g:pydiction_location = '~/.vim/pydiction/complete-dict'
let g:pydiction_menu_height = 6

set backupdir=~/.vim/backup
set directory=~/.vim/backup

"search options
set nohlsearch
set ignorecase
set smartcase

set ve=block
"set fenc=utf-8

set shiftwidth=4
"too controvercial...
"set tabstop=4

" Long lines
set linebreak
set showbreak=>
map <Up> gk
map <Down> gj

" Middle mouse
" Prevent accidental pasting
map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>

set guioptions-=T

set lines=40 columns=100

colorscheme wombat

" FuzzyFinder
let g:fuf_modesDisable = []

