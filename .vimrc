au BufNewFile,BufRead *.es6 set filetype=js

"
" Vundle Config
"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'gertjanreynaert/cobalt2-vim-theme'

call vundle#end()            
filetype plugin indent on    

"
" Generic Settings 
"

set nocompatible              " be iMproved, required
set noswapfile
filetype on                  " required
syntax on

set number

"set tabstop=2 shiftwidth=2 noexpandtab
"enable this for space identation
set tabstop=2 shiftwidth=2 expandtab

call pathogen#infect()

"
" Style Settings
"

set t_Co=256
set background=dark

" set colorscheme
colorscheme cobalt2

"set hls
" custom color settings
"hi Directory guifg=#FF0000 ctermfg=red
hi SignColumn ctermbg=Black
"hi LineNr ctermfg=yellow

" change fold color
" hi Folded ctermbg=green

set runtimepath^=~/.vim/bundle/ctrlp.vim

syntax enable
"filetype plugin indent on

" show wrap line indicator
highlight ColorColumn ctermbg=black guibg=black
set colorcolumn=81

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

"
" Syntastic Configuration 
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"
" Ultisnips configuration. 
"


" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"
"let g:UltiSnipsExpandTrigger="<tab>"
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

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"
" Key bindings o O
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
	command! -bang T tabnew<bang>
	command! -bang Wrap set colorcolumn=80<bang>
	command! -bang Tabs set tabstop=2 shiftwidth=2 noexpandtab<bang>
	command! -bang Spaces set tabstop=2 shiftwidth=2 expandtab<bang>
	command! -bang Scss UltiSnipsAddFiletypes scss.css<bang>
endif


"
" Show Relative Line Numbers
"

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
