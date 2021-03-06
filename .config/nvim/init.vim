syntax on
filetype plugin on
set nocompatible
set number

set backupdir=$HOME/.vim-backup
set directory=$HOME/.vim-backup

set encoding=utf-8
set guioptions-=T

set hidden

set undofile

set nohlsearch
set ignorecase
set smartcase

set modeline


" remove trailing whitespace before writing
autocmd BufWritePre * %s/\s\+$//e


" auto correct
iab teh the
iab paramter parameter


" Moving between windows
" Need these to disable other C-j mappings
let g:C_Ctrl_j = 'off'
nnoremap <M-J> <Plug>IMAP_JumpForward

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F[vi[<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>

" force-write readonly files
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


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
au BufRead,BufNewFile *.dts set filetype=dts number
au BufRead,BufNewFile *.dtsi set filetype=dts number
au BufRead,BufNewFile run.log set filetype=walog
au BufRead,BufNewFile *.weechatlog set filetype=irc
au BufRead,BufNewFile *.xaml set filetype=xml number
au BufRead,BufNewFile *.rst set filetype=rrst textwidth=80
au BufRead,BufNewFile *.html set syntax=htmljinja number
au BufRead,BufNewFile README* set filetype=rst textwidth=80
au BufRead,BufNewFile *PULLREQ_EDITMSG set spell textwidth=80
au BufRead,BufNewFile *COMMIT_EDITMSG set spell textwidth=80
au BufRead,BufNewFile *.md set filetype=markdown number

" Ranger file chooser
let g:ranger_terminal = 'urxvt -e'
let g:ranger_replace_netrw = 1
map <leader>f :silent RangerEdit<CR>


" Tab completion
set wildmode=longest,list,full
set wildmenu


" Quickfix
nnoremap ]e :cn
nnoremap [e :cp


" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'xolox/vim-notes'  " plugin for note taking
Plug 'xolox/vim-misc'  " plugin for note taking
Plug 'hari-rangarajan/CCTree' " cscope-based call tree navitation
Plug 'Rykka/clickable.vim' " Makes links in files clickabke
Plug 'ctrlpvim/ctrlp.vim'  " File opener
Plug 'tpope/vim-sensible'  " sensible defaults
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-tidy --go-completer --clangd-completer --java-completer --system-libclang --clang-completer' }  " auto comletion
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'} " automatic flags generator for YCM
Plug 'jonathanfilip/vim-lucius'  " colorscheme
Plug 'scrooloose/nerdcommenter'  " comment code
Plug 'jlanzarotta/bufexplorer'   " Better switching between buffers
Plug 'majutsushi/tagbar'  " Sidebar listing tags (classes, functions, etc.) in the current file
Plug 'nielsadb/vim-filtering'  " Filter lines in a buffer and jump between filtered lines
Plug 'clones/vim-l9'  " Needed for the fuzzy finder below
Plug 'clones/vim-fuzzyfinder'  " Fuzzy search for buffers, lines, and files
Plug 'chase/vim-ansible-yaml'  " Sensible YAML editing
Plug 'asciidoc/vim-asciidoc'  " asciidoc syntax
Plug 'jceb/vim-orgmode'  " Organizer, inspired by emacs' org-mode
Plug 'tpope/vim-speeddating'  " Better C-A and C-X for dates
Plug 'benmills/vimux'  " Vim-tmux integration; run shell commands from within vim
Plug 'vim-scripts/utl.vim'  " Universal Text Linking
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rbgrouleff/bclose.vim'  " Dependency for ranger
Plug 'francoiscabrol/ranger.vim'  " Use ranger as directory browser
Plug 'tpope/vim-fugitive'
Plug 'rafaqz/ranger.vim'
Plug 'johngrib/vim-game-code-break'
Plug 'chrisbra/csv.vim'
Plug 'zirrostig/vim-schlepp'  " Move text around
Plug 'rust-lang/rust.vim'  " rust support
Plug 'trapd00r/irc.vim'  " IRC log syntax highlighting
Plug 'Scuilion/markdown-drawer'  " Markdown drawer (navigation tree)
Plug 'nathanalderson/yang.vim'   " YANG syntax file
call plug#end()

" schlepp
vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight

" Colorscheme
colorscheme jellybeans

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1


" Disable preview on completion
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
set completeopt-=preview


"CTRLP
let g:ctrlp_max_height = 30


" cscope
nnoremap <leader>h :execute 'cs f s ' . expand('<cword>')<CR>


" mutt email editing
"
" Tip: Place the cursor in the optimal position, editing email messages.
" Author: Davide Alberani
" Version: 0.1
" Date: 24 May 2006
" Description: if you use Vim to edit your emails, having to manually
" move the cursor to the right position can be quite annoying.
" This command will place the cursor (and enter insert mode)
" in the more logical place: at the Subject header if it's
" empty or at the first line of the body (also taking
" care of the attribution, to handle replies messages).
" Usage: I like to call the Fip command by setting the command that is used
" by my mail reader (mutt) to execute Vim. E.g. in my muttrc I have:
" set editor="vim -c ':Fip'"
" Obviously you can prefer to call it using an autocmd:
" " Modify according to your needs and put this in your vimrc:
" au BufRead mutt* :Fip
" Hints: read the comments in the code and modify it according to your needs.
" Keywords: email, vim, edit, reply, attribution, subject, cursor, place.

" Function used to identify where to place the cursor, editing an email.
function! FirstInPost (...) range
  let cur = a:firstline
  while cur <= a:lastline
    let str = getline(cur)
    " Found an _empty_ subject in the headers.
    " NOTE: you can put similar checks to handle other empty headers
    " like To, From, Newgroups, ...
    if str == 'Subject: '
      execute cur
      :start!
      break
    endif
    " We have reached the end of the headers.
    if str == ''
      let cur = cur + 1
      " If the first line of the body is an attribution, put
      " the cursor _after_ that line, otherwise the cursor is
      " leaved right after the headers (assuming we're writing
      " a new mail, and not editing a reply).
      " NOTE: modify the regexp to match your mail client's attribution!
      "if strlen(matchstr(getline(cur), '^On.*wrote:.*')) > 0
        "let cur = cur + 1
      "endif
      execute cur
      ":start
      break
    endif
    let cur = cur + 1
  endwhile
endfunction

function! Resyntax()
    syntax on
endfunction

com! Resyn :call Resyntax()
nnoremap <leader>r :Resyn<CR>

" Command to be called.
com! Fip :set tw=0<Bar>:%call FirstInPost()
au BufRead,BufNewFile /tmp*/mutt-* :Fip
au BufRead,BufNewFile /tmp*/mutt-* set textwidth=72 spell softtabstop=4 shiftwidth=4 autoindent formatoptions=tcq


" FuzzyFinder
" nmap <leader>f :FufFile<CR>
" ^^^ using ranger for this instead -- see below
nnoremap <leader>l :FufLine<CR>
nnoremap <leader>b :FufBuffer<CR>


" vim-filtering
function! FilterUserInput()
        let obj =  FilteringNew()
        call obj.parseQuery(input('>'), '|')
        call obj.run()
endfunction

nnoremap ,F :call FilteringNew().addToParameter('alt', @/).run()<CR>
nnoremap ,f :call FilterUserInput()<CR>
nnoremap ,g :call FilteringGetForSource().return()<CR>
nnoremap ,v :call FilteringNew().addToParameter('alt', expand("<cword>")).run()<CR>


" BufExplorer
" Re-mapping as it conflicts with FufBuffer (well, it still works but makes
" FufBuffer slower).
" I've unmapped the defaults in the bufexplorer.vim, as I'm not sure how to
" unmap them from here.
nnoremap <Leader>ee :BufExplorer<CR>
nnoremap <Leader>es :BufExplorerHorizontalSplit<CR>
nnoremap <Leader>ev :BufExplorerVerticalSplit<CR>


" Tagbar
nnoremap <F8> :TagbarOpenAutoClose<CR>
nnoremap <Leader>tt :TagbarToggle<CR>


" CTRL-P
let g:ctrlp_open_new_file = 'r'


" notes
let g:notes_directories = ['~/notes']


" date
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %H:%M ")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %H:%M ")<CR>


"Remove all trailing whitespace
nnoremap <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


" Hightlight trailing whitespace
highlight Trail ctermbg=black guibg=darkred
call matchadd('Trail', '\s\+$', 100)


" Project-specific
au BufRead,BufNewFile /data/projects/attestation/code/attestation-prototype/* let g:pymode_breakpoint_cmd = "import rpdb; debugger = rpdb.Rpdb(addr='0.0.0.0', port=5858); debugger.set_trace()  # XXX BREAKPOINT"

