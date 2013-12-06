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


""" ---------------------
""" setrofim's settings
""" ---------------------

" Pathogen
execute pathogen#infect()
Helptags

syntax on
filetype plugin indent on

set backupdir=$HOME/.vim-backup
set directory=$HOME/.vim-backup

set encoding=utf-8
set guioptions-=T

set hidden

set nohlsearch
set ignorecase
set smartcase

" Moving across wrapped lines
:nmap <Down> gj
:nmap <Up> gk


map <F9> :PyLint<CR>
map <F12> :execute 'tselect' expand('<cword>')<CR>

" Moving between windows
" Need these to disable other C-j mappings
let g:C_Ctrl_j = 'off'
nnoremap <M-J> <Plug>IMAP_JumpForward

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" http://statico.github.com/vim.html
" Make vim command line behave more like bash
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Remap F1 as I keep hitting it by mistake
inoremap <F1> <Esc>
noremap <F1> :call MapF1()<CR>

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction


" File extentions
au BufRead,BufNewFile *.xaml set filetype=xml
au BufRead,BufNewFile *.rst set textwidth=80
au BufRead,BufNewFile *.html set syntax=htmljinja
au BufRead,BufNewFile README* set filetype=rst textwidth=80


" Tab completion
set wildmode=longest,list,full
set wildmenu


" Quickfix
nmap ]e :cn
nmap [e :cp


" Pathogen
execute pathogen#infect()
Helptags


" Powerline
if has("win32")

	set guifont=Consolas\ for\ Powerline\ FixedD:h10
else

	" set guifont=DejaVu\ Sans\ Mono\ 9
	set guifont=Liberation\ Mono\ 9
endif
set laststatus=2
"let g:Powerline_symbols="fancy"


" FuzzyFinder
nmap <leader>f :FufFile<CR>
nmap <leader>l :FufLine<CR>
nmap <leader>b :FufBuffer<CR>


" Quich Filter
function FilterUserInput()
	let obj =  FilteringNew()
	call obj.parseQuery(input('>'), '|')
	call obj.run()
endfunction

nnoremap ,F :call FilteringNew().addToParameter('alt', @/).run()<CR>
nnoremap ,f :call FilterUserInput()<CR>
nnoremap ,g :call FilteringGetForSource().return()<CR>

" Python Mode
let g:pymode_lint_write = 0
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"

nmap <leader>xl :PyLint<CR>
nmap <leader>xr :RopeRename<CR>

" Ignore:
" W391: Blank line at end of file
" W801: Redefinition of unused
let g:pymode_lint_ignore = "W391,E501,W801"

let g:pymode_doc = 0
" let g:pymode_doc_key = 'K'

let g:pymode_folding = 0
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<F7>'
let g:pymode_utils_whitespaces = 1
let g:pymode_syntax_space_errors = 0

" Turing off pymode version of ropevim as I'm using the later stand alone
" version.
" let g:pymode_rope = 0
let g:pymode_rope_map_space = 1
" let g:ropevim_vim_completion = 1
let g:ropevim_extended_complete = 1
let g:ropevim_autoimport_modules = ["os.*","traceback","django.*", "xml.etree"]
" Switching rope completion from default CTRL-space to CTRL-n
" inoremap <silent> <buffer> <c-n> <C-R>=RopeCodeAssistInsertMode()<CR>

" NERDTree
let g:NERDTreeHijackNetrw = 0


" BufExplorer
" Re-mapping as it conflicts with FufBuffer (well, it still works but makes
" FufBuffer slower).
" I've unmapped the defaults in the bufexplorer.vim, as I'm not sure how to
" unmap them from here.
nmap <Leader>ee :BufExplorer<CR>
nmap <Leader>es :BufExplorerHorizontalSplit<CR>
nmap <Leader>ev :BufExplorerVerticalSplit<CR>


" Tagbar
nmap <F8> :TagbarOpenAutoClose<CR>
nmap <Leader>tt :TagbarToggle<CR>


" Latex Suite
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


" Close Tags
let g:closetag_html_style=1
au BufRead,BufNewFile *.html,*.xml,*.xsl source $HOME/vimfiles/scripts/closetag.vim 

" Get vim to open a scratch buffer by default -- Emacs style.
function CheckScratch()
	let fname = expand("%:p")
	if fname == "" 
		"Scratch 
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
		setlocal buflisted
	endif
endfunction

autocmd VimEnter *  call CheckScratch()

" Enable syntax highlighting when buffers were loaded through :bufdo, which
" disables the Syntax autocmd event to speed up processing.
augroup EnableSyntaxHighlighting
    " Filetype processing does happen, so we can detect a buffer initially
    " loaded during :bufdo through a set filetype, but missing b:current_syntax.
    " Also don't do this when the user explicitly turned off syntax highlighting
    " via :syntax off.
    " Note: Must allow nesting of autocmds so that the :syntax enable triggers
    " the ColorScheme event. Otherwise, some highlighting groups may not be
    " restored properly.
    autocmd! BufWinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) | syntax enable | endif

    " The above does not handle reloading via :bufdo edit!, because the
    " b:current_syntax variable is not cleared by that. During the :bufdo,
    " 'eventignore' contains "Syntax", so this can be used to detect this
    " situation when the file is re-read into the buffer. Due to the
    " 'eventignore', an immediate :syntax enable is ignored, but by clearing
    " b:current_syntax, the above handler will do this when the reloaded buffer
    " is displayed in a window again.
    autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif
augroup END

"Ghetto Powerline
let g:last_mode = ""

function! Mode()
	let l:mode = mode()

	if l:mode !=# g:last_mode "Mode change
	let g:last_mode = l:mode
	if     mode ==# "n"  | hi User2 ctermfg=28  ctermbg=22  cterm=bold | hi User3 ctermfg=22  ctermbg=236
	elseif mode ==# "i"  | hi User2 ctermfg=23  ctermbg=231 cterm=bold | hi User3 ctermfg=231 ctermbg=236
	elseif mode ==# "R"  | hi User2 ctermfg=231 ctermbg=160 cterm=bold | hi User3 ctermfg=160 ctermbg=236
	elseif mode ==? "v"  | hi User2 ctermfg=160 ctermbg=208 cterm=bold | hi User3 ctermfg=208 ctermbg=236
	elseif mode ==# "^V" | hi User2 ctermfg=160 ctermbg=208 cterm=bold | hi User3 ctermfg=208 ctermbg=236
	endif
	endif

	if     mode ==# "n"  | return " NORMAL "
	elseif mode ==# "i"  | return " INSERT "
	elseif mode ==# "R"  | return " REPLACE "
	elseif mode ==# "v"  | return " VISUAL "
	elseif mode ==# "V"  | return " V·LINE "
	elseif mode ==# "^V" | return " V·BLOCK "
	else                 | return l:mode
	endif

	let g:last_mode = l:mode
endfunc

function! GetBranch()
	let ret = fugitive#statusline()
	let ret = substitute(ret, '\c\v\[?GIT\(([a-z0-9\-_\./:]+)\)\]?', '〉⑂' .' \1', 'g')
	return ret
endfunction 

function! GetFile()
	let ret = expand('%:t')
	if ret == '' || ret == '__Scratch__'
		let ret = '[Scratch]'
	elseif ret == 'COMMIT_EDITMSG'
		let ret = '[Commit Message]'
	else
		let ret = ' ⑇ ' . ret
	endif
	return ret . ' '
endfunction 

function! GetStatusFlag()
	if &ro
		return 'ø'
	elseif &mod
		return '+'
	else
		return '-'
	endif
endfunction

set laststatus=2 "Always show statusline
set statusline=\ %{GetStatusFlag()}\ 〉%{Mode()}〉%{GetFile()}%{GetBranch()}%=%{&enc}\ 〈\ %{&ff}\ 〈\ %{tolower(&ft)}
set statusline+=\ [%03l:%03v\ %03p%%]


hi statusline guibg=#FFFFFF guifg=#555555

" Generic
if has("gui_running")
	set background=dark
	colorscheme solarized
	set lines=40 columns=130
	set guioptions-=T
	set guioptions-=m
else
	if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal" || $TERM == "screen"
	  set t_Co=256
	endif
	colorscheme lucius
	LuciusBlack
	hi Normal ctermbg=none
endif

