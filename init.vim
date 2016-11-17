syntax on
set shell=/bin/bash

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'

Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"ï

call plug#begin('~/.config/nvim/plug.vim')

" Make sure you use single quotes
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/syntastic'


" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'kien/ctrlp.vim'

" Using git URL
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'

Plug 'luochen1990/rainbow'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()

"
" JavaScript Settings
"

au BufNewFile,BufRead *.es6 set filetype=js

"
" Vundle Config
"
filetype plugin indent on    

"
" Generic Settings 
"

set nocompatible
set noswapfile
filetype on                  
syntax on

set relativenumber

"enable this if your team is stuck in the 90's
"set tabstop=2 shiftwidth=2 noexpandtab
"enable this for space identation
set tabstop=2 shiftwidth=2 expandtab

" call pathogen#infect()

"
" Style Settings
"

set t_Co=256
set background=dark

" set colorscheme
" colorscheme wellsokai
colorscheme brogrammer
autocmd BufNewFile *.txt :CSnext
nnoremap <C-m> :CSnext<cr>

set hls
" custom color settings
"hi Directory guifg=#FF0000 ctermfg=red
hi SignColumn ctermbg=Black
"hi LineNr ctermfg=yellow

" change fold color
" hi Folded ctermbg=green

syntax enable
"filetype plugin indent on

" show wrap line indicator
highlight ColorColumn ctermbg=black guibg=black
set colorcolumn=81

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

"
" Ycm Config
"

vmap <C-q> YcmCompleter GoToDefinition
vmap <C-d> asdf

"
" Syntastic Configuration 
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint']

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"
" Ultisnips configuration. 
"

"let g:ycm_key_list_select_completion=[]
"let g:ycm_key_list_previous_completion=[]

" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"
" let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction


au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"
" The Silver Searcher
"

if executable('ag')
  " Use ag over grep 
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l -g ""'

  let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


"
" Rainbow Paratheses Config
"

let g:rainbow_active = 1

let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': [125, 47, 39, 11, 161, 2, 166, 160, 46],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

"
" Key bindings
"

if has("user_commands")
	command! -bang -nargs=? -complete=file E e<bang> <args>
	command! -bang -nargs=? -complete=file W w<bang> <args>
	command! -bang -nargs=? -complete=file Wq wq<bang> <args>
	command! -bang -nargs=? -complete=file WQ wq<bang> <args>
	command! -bang Wa wa<bang>
	command! -bang WA wa<bang>
	command! -bang Q q<bang>
	command! -bang QA qa<bang>
	command! -bang Qa qa<bang>
	command! -bang Tr NERDTree<bang>
	command! -bang Ue UltiSnipsEdit<bang>
	command! -bang T tabnew<bang>
	command! -bang S %s/\s\+$//<bang>
	command! -bang H JsPreTmpl html<bang>
	command! -bang Wrap set colorcolumn=80<bang>
	command! -bang Tabs set tabstop=2 shiftwidth=2 noexpandtab<bang>
	command! -bang Spaces set tabstop=2 shiftwidth=2 expandtab<bang>
	command! -bang Scss UltiSnipsAddFiletypes scss.css<bang>
endif


"
" Show Relative Line Numbers
"

function! NumberToggle()
  if(&number == 0)
    set number
  endif
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

function! JsCheckerToggle()
  let g:syntastic_javascript_checkers = ['jshint']
endfunc

nnoremap <C-/> :call JsCheckerToggle()<cr>
