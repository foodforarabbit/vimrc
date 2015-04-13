set nocompatible              " be iMproved, required
" TODO: test this
filetype on                  " required
syntax on
au BufNewFile,BufRead *.es6 set filetype=js

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'Valloric/YouCompleteMe'
" Track the engine.
Plugin 'SirVer/ultisnips'

" " Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Bundle 'gertjanreynaert/cobalt2-vim-theme'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number

" enable this for tab indentation
"set tabstop=2 shiftwidth=2 noexpandtab
"enable this for space identation
set tabstop=2 shiftwidth=2 expandtab
"set shiftwidth=2


" 256 color settings
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
call pathogen#infect()
syntax enable
"filetype plugin indent on

" show wrap line indicator
set colorcolumn=80

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Syntastic Configuration 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ultisnips configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
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


" The Silver Searcher
if executable('ag')
  " Use ag over grep 
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l -g ""'

  let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

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
